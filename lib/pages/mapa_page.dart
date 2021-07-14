import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {

  

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.hybrid;

  

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    final CameraPosition puntoInicial = CameraPosition(
    
    target: scan.getLanLng(),
    zoom: 17,
    tilt: 50
  );
  //MArcadores
  Set<Marker> markers = new Set<Marker>();
  markers.add(new Marker(
    markerId: MarkerId('geo-location'),
    position: scan.getLanLng()
    )
    );

  
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_history),
             onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getLanLng(),
                    zoom: 17,
                    tilt: 50
                    )
                )
              );

             })
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        mapType: mapType,
        initialCameraPosition: puntoInicial,
        markers: markers, //agrego el marcador puedo poner tantos como quiera.
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: (){

         if (mapType == MapType.hybrid){
           mapType = MapType.normal;
         }else {
           mapType = MapType.hybrid;
         }

         setState(() {
           
         });

        },
      ),
      
    );
  }
}