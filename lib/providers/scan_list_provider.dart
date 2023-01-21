import 'package:appcodigoqr/providers/provider.dart';
import 'package:flutter/cupertino.dart';

import '../models/scan_models.dart';

class ScanListProvider extends ChangeNotifier {
  // cambia los scans para que sea visible en la app
  List<ScanModel> scans = [];
  String tipusSeleccionat = 'http';

  Future<ScanModel> nouScan(String valor) async {
    final nouScan = ScanModel(valor: valor);
    final id = await DBProvider.db.insertScan(nouScan);
    nouScan.id = id;

    if (nouScan.tipus == tipusSeleccionat) {
      this.scans.add(nouScan);
      notifyListeners();
    }
    return nouScan;
  }

  carregaScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  carregaScanPerTipus(String tipus) async {
    final scans = await DBProvider.db.getScanByTipus(tipus);
    this.scans = [...scans!];
    this.tipusSeleccionat = tipus;
    notifyListeners();
  }

  esborraTots() async {
    final scans = await DBProvider.db.deleteAllScans();
    this.scans = []; //clear
    notifyListeners();
  }

  esborraPerid(int id) async {
    final scans = await DBProvider.db.deleteScan(id);
    this.scans.removeWhere((element) => element.id == id);

    notifyListeners();
  }
}
