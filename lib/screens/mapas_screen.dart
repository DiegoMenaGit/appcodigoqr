import 'package:flutter/cupertino.dart';

import '../widgets/scan_tile.dart';

class MapasScreen extends StatelessWidget {
  // da valor a geo
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipus: 'geo');
  }
}
