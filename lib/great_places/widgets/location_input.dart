import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: locData.latitude as double,
      longitude: locData.longitude as double,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _findWithCoordinate() async {
    final longitude = TextEditingController();
    final latitude = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Container(
          width: 300,
          height: 200,
          child: Column(
            children: [
              TextField(
                  decoration: InputDecoration(labelText: 'Longitude'),
                  controller: longitude,
                  keyboardType: TextInputType.number),
              TextField(
                  decoration: InputDecoration(labelText: 'Latitude'),
                  controller: latitude,
                  keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              final staticMapImageUrl =
                  LocationHelper.generateLocationPreviewImage(
                latitude: double.parse(latitude.text),
                longitude: double.parse(longitude.text),
              );
              setState(() {
                _previewImageUrl = staticMapImageUrl;
              });
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 200,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: _previewImageUrl == null
            ? Text(
                'No Location Chosen',
                textAlign: TextAlign.center,
              )
            : Image.network(
                _previewImageUrl as String,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
            icon: Icon(Icons.location_on),
            label: Text('Current Location'),
            onPressed: _getCurrentLocation,
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          TextButton.icon(
            icon: Icon(Icons.map),
            label: Text('Enter Coordinates'),
            onPressed: _findWithCoordinate,
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          ),
        ],
      )
    ]);
  }
}
