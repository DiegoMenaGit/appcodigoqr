import 'package:appcodigoqr/models/scan_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';
import '../utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);
  // boton de enmedio que abre la camara detectora de qr

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        print('Botó polsat!');
        //geo:39.7268467,2.9111258
        //String barcodeScanRes = 'https://aulavirtual.paucasesnovescifp.cat';
        //String barcodeScanRes = 'geo:39.7268467,2.9111258';
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D88EF', 'Cancelar', false, ScanMode.QR);
        print(barcodeScanRes);

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        ScanModel nouScan = ScanModel(valor: barcodeScanRes);
        scanListProvider.nouScan(barcodeScanRes);
        launchURL(context, nouScan);
      },
    );
  }
}
