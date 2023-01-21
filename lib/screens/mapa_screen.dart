import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/scan_models.dart';

class MapaScreen extends StatefulWidget {
  // screen que sale cuando abres un qr geo, se vera el mapa reflejado dentro de la app por el widget de google
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition _puntInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
    );

    Set<Marker> markers = new Set<Marker>();
    markers
        .add(new Marker(markerId: MarkerId('id1'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa Mundi"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Reset'),
        onPressed: () {
          _controller.future.then((controller) {
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                _puntInicial,
              ),
            );
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapType: MapType.hybrid,
        markers: markers,
        initialCameraPosition: _puntInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
