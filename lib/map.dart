import 'package:church_locator/models/result_dummy_model.dart';
import 'package:church_locator/request/google_map_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class Map extends StatefulWidget {
  var churches;

  Map({this.churches});
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  static LatLng _initialPostion;
  LatLng _lastPostion = _initialPostion;
  final Set<Polyline> _polyLines = {};
  final Set<Marker> _markers = {};
  GoogleMapController _mapController;
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  GoogleMapsServices get googleMapsServices => _googleMapsServices;
  GoogleMapController get mapController => _mapController;
  TextEditingController destinationController = new TextEditingController();

  @override
  void initState() {
    _getUserLocation();

    super.initState();
  }

  _getUserLocation() async {
    // Position position = await Geolocator()
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // List<Placemark> placemark = await Geolocator()
    //     .placemarkFromCoordinates(position.latitude, position.longitude);

    List<Placemark> placemark = await Geolocator()
        .placemarkFromAddress('elekahia road,rivers state, Nigeria');
    double latitude = placemark[0].position.latitude;
    double longitude = placemark[0].position.longitude;
    LatLng destination = LatLng(latitude, longitude);

    setState(() {
      _initialPostion = LatLng(latitude, longitude);
    });
    print("the latitude is: $longitude and th longitude is: $longitude ");
    print("initial position is : ${_initialPostion.toString()}");
  }

  void _addMarker(LatLng location, String address) {
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId(_lastPostion.toString()),
            position: location,
            infoWindow: InfoWindow(title: address, snippet: "go here"),
            icon: BitmapDescriptor.defaultMarker),
      );
    });
  }

  void onCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void createRoute(String encondedPoly) {
    setState(() {
      _polyLines.add(Polyline(
          polylineId: PolylineId(_lastPostion.toString()),
          width: 10,
          points: _convertToLatLng(_decodePoly(encondedPoly)),
          color: Colors.black));
    });
  }

  void sendRequest(String intendedLocation) async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromAddress(intendedLocation);
    double latitude = placemark[0].position.latitude;
    double longitude = placemark[0].position.longitude;
    LatLng destination = LatLng(latitude, longitude);
    String route = await _googleMapsServices.getRouteCoordinates(
        _initialPostion, destination);
    _addMarker(destination, intendedLocation);
    createRoute(route);
  }

  void onCameraMove(CameraPosition position) {
    setState(() {
      _lastPostion = position.target;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _initialPostion == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: onCreated,
                initialCameraPosition: CameraPosition(
                  target: _initialPostion,
                  zoom: 10,
                ),
                mapType: MapType.normal,
                myLocationEnabled: true,
                compassEnabled: true,
                onCameraMove: onCameraMove,
                polylines: _polyLines,
                markers: _markers,
              ),
              Positioned(
                top: 10,
                left: 20,
                right: 20,
                child: Card(
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: destinationController,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) {
                      sendRequest(value);
                    },
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
                      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                    ),
                  ),
                ),
              )
            ],
          );
  }
}

// ! ADD A MARKER ON THE MAO

// ! CREATE LAGLNG LIST
List<LatLng> _convertToLatLng(List points) {
  List<LatLng> result = <LatLng>[];
  for (int i = 0; i < points.length; i++) {
    if (i % 2 != 0) {
      result.add(LatLng(points[i - 1], points[i]));
    }
  }
  return result;
}

// !DECODE POLY
List _decodePoly(String poly) {
  var list = poly.codeUnits;
  var lList = new List();
  int index = 0;
  int len = poly.length;
  int c = 0;
// repeating until all attributes are decoded
  do {
    var shift = 0;
    int result = 0;

    // for decoding value of one attribute
    do {
      c = list[index] - 63;
      result |= (c & 0x1F) << (shift * 5);
      index++;
      shift++;
    } while (c >= 32);
    /* if value is negetive then bitwise not the value */
    if (result & 1 == 1) {
      result = ~result;
    }
    var result1 = (result >> 1) * 0.00001;
    lList.add(result1);
  } while (index < len);

/*adding to previous value as done in encoding */
  for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

  print(lList.toString());

  return lList;
}
