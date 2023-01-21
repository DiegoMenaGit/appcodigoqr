import 'package:flutter/cupertino.dart';

class UIProvider extends ChangeNotifier {
  //suma
  int _selectedMenuOpt = 1;

  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int index) {
    this._selectedMenuOpt = index;
    notifyListeners();
  }
}
