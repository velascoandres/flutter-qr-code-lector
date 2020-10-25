import 'dart:async';

import 'package:qr_code_lector/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _scansBloc = new ScansBloc._internal();

  final _scanStreamController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scanStreamController.stream;

  factory ScansBloc() {
    return _scansBloc;
  }

  ScansBloc._internal() {
    // Obtener los scans de la base de datos
    obtenerScans();
  }

  dispose() {
    _scanStreamController?.close();
  }

  void obtenerScans() async {
    final scans = await DBProvider.db.obtenerScans();
    _scanStreamController.sink.add(scans);
  }

  void agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  void borrarScan(int id) async {
    await DBProvider.db.eliminarRegistro(id);
    obtenerScans();
  }

  void borrarScanTodo() async {
    await DBProvider.db.eliminarTodo();
    obtenerScans();
  }
}

// final scansBloc = new ScansBloc();
