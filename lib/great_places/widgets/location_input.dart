import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();
      final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        lat: locData.latitude as double,
        lng: locData.longitude as double,
      );
      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _getEnteredLocation() async {
    final longitude = TextEditingController();
    final latitude = TextEditingController();
    final placeName = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Container(
          width: 300,
          height: 200,
          child: Column(
            children: [
              TextField(
                  decoration: InputDecoration(labelText: 'Latitude'),
                  controller: latitude,
                  keyboardType: TextInputType.number),
              TextField(
                  decoration: InputDecoration(labelText: 'Longitude'),
                  controller: longitude,
                  keyboardType: TextInputType.number),
              Expanded(child: Text('Or')),
              TextField(
                decoration: InputDecoration(labelText: 'Place Name'),
                controller: placeName,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Ok'),
            onPressed: () async {
              if (placeName.text.isNotEmpty) {
                final coordinates =
                    await LocationHelper.getPlaceCoordinates(placeName.text);
                latitude.text = coordinates[0].toString();
                longitude.text = coordinates[1].toString();
              }

              final staticMapImageUrl =
                  LocationHelper.generateLocationPreviewImage(
                lat: double.parse(latitude.text),
                lng: double.parse(longitude.text),
              );
              setState(() {
                _previewImageUrl = staticMapImageUrl;
              });

              Navigator.of(ctx).pop();
              widget.onSelectPlace(
                  double.parse(latitude.text), double.parse(longitude.text));
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
            label: Text('Enter Location'),
            onPressed: _getEnteredLocation,
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          ),
        ],
      )
    ]);
  }
}
