import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/utils/database.dart';

class GoogleMapShowTime extends StatefulWidget {
  GoogleMapShowTime({this.uid,this.markerLocation, this.userLocation, this.onTap});
  final LatLng markerLocation;
  final LatLng userLocation;
  final onTap;
  final uid;

  @override
  _GoogleMapShowTimeState createState() => _GoogleMapShowTimeState();
}

class _GoogleMapShowTimeState extends State<GoogleMapShowTime> {
  String resultAddress;
  double lat;
  double lon;

  Future<dynamic> getSetAddress() async {
    lat = widget.markerLocation == null
        ? widget.userLocation.latitude
        : widget.markerLocation.latitude;
    lon = widget.markerLocation == null
        ? widget.userLocation.longitude
        : widget.markerLocation.longitude;
    final addresses = await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(lat, lon));
    return resultAddress = addresses.first.addressLine;
  }

  @override
  Widget build(BuildContext context) {
    lat = widget.markerLocation == null
        ? widget.userLocation.latitude
        : widget.markerLocation.latitude;
    lon = widget.markerLocation == null
        ? widget.userLocation.longitude
        : widget.markerLocation.longitude;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                myLocationEnabled: true,
                onTap: widget.onTap,
                markers: widget.markerLocation != null
                    ? [
                        Marker(
                          markerId: MarkerId('My sweet Home'),
                          position: widget.markerLocation,
                        )
                      ].toSet()
                    : null,
                compassEnabled: true,
                initialCameraPosition: CameraPosition(
                    target: widget.userLocation ?? LatLng(11.1271, 78.6569),
                    zoom: 10),
                mapType: MapType.normal,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'LATITUDE : $lat,\nLONGITUDE : $lon',
                    style: TextStyle(color: kHomeColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<dynamic>(
                      future: getSetAddress(),
                      builder: (context, snapshot) {
                        switch (snapshot.hasData) {
                          case true:
                            return Text(
                              'Address :\n$resultAddress',
                              style: TextStyle(color: kRegisterBackgroundColor),
                            );
                          default:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                        }
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                    onPressed: () {
                      try {
                        Database().customerLocationData(
                          uid: widget.uid,
                          lat: lat,
                          lon: lon,
                          address: resultAddress,
                        );
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text('CONFIRM LOCATION'),
                    color: kRegisterBackgroundColor,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
