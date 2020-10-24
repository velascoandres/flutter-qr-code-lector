import 'package:flutter/material.dart';
import 'package:qr_code_lector/src/providers/db_provider.dart';

class MapasPage extends StatelessWidget {
  const MapasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBProvider.db.obtenerScans(),
      builder: (context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (snapshot.hasData) {
          final scans = snapshot.data;
          if (scans.length == 0) {
            return Center(
              child: Text('No existen registros'),
            );
          }
          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, i) => ListTile(
              leading: Icon(
                Icons.cloud_queue,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                scans[i].valor,
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
