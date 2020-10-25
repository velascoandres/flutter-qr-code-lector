import 'package:flutter/material.dart';
import 'package:qr_code_lector/src/bloc/scans_bloc.dart';
import 'package:qr_code_lector/src/models/scan_model.dart';
import 'package:qr_code_lector/src/utils/utils.dart' as utils;

class MapasPage extends StatelessWidget {
  MapasPage({Key key}) : super(key: key);

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: scansBloc.scansStream,
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
            itemBuilder: (context, i) => Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.redAccent,
              ),
              onDismissed: (direccion) {
                final id = scans[i].id;
                scansBloc.borrarScan(id);
              },
              child: ListTile(
                onTap: () => utils.abrirScan(scans[i]),
                leading: Icon(
                  Icons.cloud_queue,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  scans[i].valor,
                ),
                subtitle: Text('ID: ${scans[i].id}'),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
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
