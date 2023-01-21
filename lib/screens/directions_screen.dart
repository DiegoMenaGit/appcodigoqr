import 'package:flutter/cupertino.dart';

import '../widgets/widgets.dart';

class DireccionsScreen extends StatelessWidget {
  // da valor a direccion http
  const DireccionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipus: 'http');
  }
}
