import 'package:appcodigoqr/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  //pagina principal que sirve de menu
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false)
                  .esborraTots();
            },
          )
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    // Canviar per a anar canviant entre pantalles
    final currentIndex = uiProvider.selectedMenuOpt;

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    // Creacio temp de bbdd
    DBProvider.db.database;

    switch (currentIndex) {
      case 0:
        scanListProvider.carregaScanPerTipus('geo');
        return MapasScreen();

      case 1:
        scanListProvider.carregaScanPerTipus('http');
        return DireccionsScreen();

      default:
        scanListProvider.carregaScanPerTipus('geo');
        return MapasScreen();
    }
  }
}
