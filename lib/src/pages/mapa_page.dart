import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qr_code_lector/src/models/scan_model.dart';
import "package:latlong/latlong.dart";

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
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
      body: _crearFlutterMapa(scanModel),
    );
  }

  Widget _crearFlutterMapa(ScanModel scanModel) {
    final latLong = scanModel.latLong;
    return FlutterMap(
      options: MapOptions(
        center: LatLng(latLong[0], latLong[1]),
        zoom: 15,
      ),
      layers: [
        _crearMapa(latLong[0], latLong[1]),
      ],
    );
  }

  LayerOptions _crearMapa(x, y) {
    return TileLayerOptions(
      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
      subdomains: ['a', 'b', 'c'],
    );
  }

}

