import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/scan_models.dart';

void launchURL(BuildContext context, ScanModel scan) async {
  // iniciar URL
  final url = scan.valor;
  if (scan.tipus == 'http') {
    if (!await launch(url)) throw 'Could not launch $url';
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
