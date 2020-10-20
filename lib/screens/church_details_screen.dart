import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../states/app_state.dart';
import 'package:geolocator/geolocator.dart';
import '../map.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChurchDetailsScreen extends StatefulWidget {
  static final String routeName = "/churchDetailsScreen";
  List churches;
  String id;
  ChurchDetailsScreen({this.churches, this.id});
  @override
  _ChurchDetailsScreenState createState() => _ChurchDetailsScreenState();
}

class _ChurchDetailsScreenState extends State<ChurchDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final id = widget.id;
    final incomingChurch = widget.churches.firstWhere((church) {
      return church['id'] == id;
    });
    print(incomingChurch);

    appState.sendRequest(incomingChurch['churchAddress'],
        incomingChurch['churchName'].toString());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 350.0,
                  child: CachedNetworkImage(
                    imageUrl: incomingChurch['churchImage'],
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 350.0,
                  color: Colors.black.withOpacity(0.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        padding: EdgeInsets.all(7.0),
                        width: 50.0,
                        height: 30.0,
                        color: Colors.blue,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "0",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0, top: 10.0),
                        child: Text(
                          incomingChurch['churchName'],
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 30.0,
                        margin: EdgeInsets.only(top: 5.0, left: 20.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "${widget.churches.length}",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 240.0,
                  left: 20.0,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: 100.0,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.white)),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Share",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 240.0,
                  left: 140.0,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: 100.0,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.white)),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.report,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Report",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: double.infinity,
              height: 150.0,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2.0, color: Colors.orange)),
                      width: 150,
                      height: 30,
                      child: Text(
                        "Church Details",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child:
                          Text("Address: " + incomingChurch['churchAddress']),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child:
                          Text("Location: " + incomingChurch['churchLocation']),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Card(
                child: Stack(
                  children: <Widget>[
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: appState.initialPosition, zoom: 10.0),
                      onMapCreated: appState.onCreated,
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      compassEnabled: true,
                      markers: appState.markers,
                      onCameraMove: appState.onCameraMove,
                      polylines: appState.polyLines,
                    ),
                    Positioned(
                      top: 50.0,
                      right: 15.0,
                      left: 15.0,
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1.0, 5.0),
                                blurRadius: 10,
                                spreadRadius: 3)
                          ],
                        ),
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: appState.locationController,
                          decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(left: 20, top: 5),
                              width: 10,
                              height: 10,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.black,
                              ),
                            ),
                            hintText: "pick up",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 16.0),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 105.0,
                      right: 15.0,
                      left: 15.0,
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1.0, 5.0),
                                blurRadius: 10,
                                spreadRadius: 3)
                          ],
                        ),
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: appState.destinationController,
                          textInputAction: TextInputAction.go,
                          // onSubmitted: (value) {
                          //   appState.sendRequest(value);
                          // },
                          decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(left: 20, top: 5),
                              width: 10,
                              height: 10,
                              child: Icon(
                                Icons.local_taxi,
                                color: Colors.black,
                              ),
                            ),
                            hintText: "destination?",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 16.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
