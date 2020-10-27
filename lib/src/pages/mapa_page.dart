import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:qr_code_lector/src/constantes/tokens.dart';
import 'package:qr_code_lector/src/models/scan_model.dart';
import 'package:flutter_map/flutter_map.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  MapboxMapController mapController;

  @override
  Widget build(BuildContext context) {
    final ScanModel scanModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {},
          )
        ],
      ),
      body: _renderizarMapa(scanModel),
    );
  }

  // Widget _crearFlutterMapa(ScanModel scanModel) {
  //   final latLong = scanModel.latLong;
  //   return FlutterMap(
  //     options: MapOptions(
  //       center: LatLng(latLong[0], latLong[1]),
  //       zoom: 10,
  //     ),
  //     layers: [
  //       _crearMapa(latLong[0], latLong[1]),
  //     ],
  //   );
  // }

  LayerOptions _crearMapa(x, y) {
    // https://api.mapbox.com/styles/v1/mapbox/outdoors-v11/static/-115.84178,37.21776,12/500x500@2x?access_token=pk.eyJ1IjoidmVsYXNjb2FuZHJzIiwiYSI6ImNrZ3BncWE4ZjA5czUyenFxMmM1MTh2b2sifQ.o6faeXYecXpVa01RabAilQ
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
          '{id}/{z}/{x},{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': TOKENS['mapbox'],
        'y': y.toString(),
        'x': x.toString(),
        'id': 'mapbox.dark',
      },
    );
  }

  _renderizarMapa(ScanModel scanModel) {
    final latLong = scanModel.latLong;
    return MapboxMap(
      accessToken: TOKENS['mapbox'],
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        zoom: 15,
        target: LatLng(
          latLong[0],
          latLong[1],
        ),
      ),
    );
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }
}

// token: pk.eyJ1IjoidmVsYXNjb2FuZHJzIiwiYSI6ImNrZ3BndXJzbzBtbHAyeW10ZDJod3MyYmgifQ.aCaJiR5X3F-hMbNe8cZpFw

// return TileLayerOptions(
//         urlTemplate: 'https://api.tiles.mapbox.com/v4/'
//             '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
//         additionalOptions: {
//         'accessToken':'pk.eyJ1Ijoiam9yZ2VncmVnb3J5IiwiYSI6ImNrODk5aXE5cjA0c2wzZ3BjcTA0NGs3YjcifQ.H9LcQyP_-G9sxhaT5YbVow',
//         'id': 'mapbox.streets'
//         }
// );
