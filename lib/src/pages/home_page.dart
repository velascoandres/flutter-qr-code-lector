import 'package:flutter/material.dart';
import 'package:qr_code_lector/src/bloc/scans_bloc.dart';
import 'package:qr_code_lector/src/models/scan_model.dart';
import 'package:qr_code_lector/src/pages/mapas_page.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'direcciones_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaActual = 0;

  final scanBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scanBloc.borrarScanTodo,
          ),
        ],
      ),
      body: Center(
        child: _callPage(paginaActual),
      ),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: paginaActual,
      onTap: (index) {
        paginaActual = index;
        setState(() {});
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.map,
          ),
          label: 'Mapas',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.brightness_5,
          ),
          label: 'Dirreciones',
        ),
      ],
    );
  }

  _scanQR() async {
    // https://github.com/
    // geo:40.2323, -73.131231
    ScanResult resultado;
    // String futureString = '';
    String futureString = 'https://github.com/';
    // try {
    //   resultado = await BarcodeScanner.scan();
    //   futureString = resultado.rawContent;
    // } catch (e) {
    //   futureString = e.toString();
    // }

    if (futureString != null) {
      final nuevoScan = ScanModel(
        valor: futureString,
      );
      scanBloc.agregarScan(nuevoScan);
    }
  }
}
