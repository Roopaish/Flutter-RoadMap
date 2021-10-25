import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(
            'Please note that this app is made to access native device features. Since Web doesn\'t have any standard filesystem, the app might not work as expected on web.',
            textAlign: TextAlign.center,
          ),
          Expanded(
              child: FutureBuilder(
            future: Provider.of<GreatPlaces>(context, listen: false)
                .fetchAndSetPlaces(),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: Center(
                      child: Text('Got no places yet, start adding some!'),
                    ),
                    builder: (ctx, greatPlaces, child) =>
                        greatPlaces.items.length <= 0
                            ? child as Widget
                            : ListView.builder(
                                itemCount: greatPlaces.items.length,
                                itemBuilder: (ctx, i) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(greatPlaces.items[i].image),
                                  ),
                                  title: Text(greatPlaces.items[i].title),
                                  onTap: () {},
                                ),
                              ),
                  ),
          ))
        ],
      ),
    );
  }
}
