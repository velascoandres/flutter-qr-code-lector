import 'package:qr_code_lector/src/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';

abrirScan(ScanModel scanModel) async {
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
    print('GEO: $geo');
  }
}
