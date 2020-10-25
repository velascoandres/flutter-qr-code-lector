import 'package:flutter/material.dart';

import 'package:qr_code_lector/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

abrirScan(BuildContext context, ScanModel scanModel) async {
  final esHttp = scanModel.tipo;
  if (esHttp == 'http') {
    final url = scanModel.valor;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se puede abrir $url';
    }
  } else {
    final geo = scanModel.valor;
    Navigator.pushNamed(context, 'mapa', arguments: scanModel);
  }
}
