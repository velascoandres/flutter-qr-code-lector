import 'dart:async';

import 'package:qr_code_lector/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _scansBloc = new ScansBloc._internal();

  final _scanStreamController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>>get scansStream => _scanStreamController.stream;

  factory ScansBloc() {
    return _scansBloc;
  }

  ScansBloc._internal() {
    // Obtener los scans de la base de datos
  }

  dispose() {
    _scanStreamController?.close();
  }
}

// final scansBloc = new ScansBloc();
