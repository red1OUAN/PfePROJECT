import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  bool isFilterOn = false;
  bool get filterState => isFilterOn;

  void changeState() {
    isFilterOn = !isFilterOn;
    notifyListeners();
  }

  bool isMainFilterOn = false;
  bool get MainfilterState => isMainFilterOn;

  void changeStateMainFilter() {
    isMainFilterOn = !isMainFilterOn;
    notifyListeners();
  }

  bool isUnreadOn = false;
  bool get UnreadState => isUnreadOn;

  void changeStateUnread() {
    isUnreadOn = true;
    notifyListeners();
  }

  void disableStateUnread() {
    isUnreadOn = false;
    notifyListeners();
  }

  List<bool> FilterList = [
    true,
    false,
    false,
    false,
  ];
  List<bool> get showFilterList => FilterList;

  void changeStateFilterList(List<bool> exe) {
    FilterList = exe;
    notifyListeners();
  }
}
