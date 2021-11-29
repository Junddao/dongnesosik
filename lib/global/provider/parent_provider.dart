import 'package:dongnesosik/global/enums/view_state.dart';
import 'package:flutter/material.dart';

class ParentProvider with ChangeNotifier {
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  void initailize() async {
    _state = ViewState.Busy;
  }

  void uninitialize() async {
    _state = ViewState.Idle;
  }

  setStateBusy() {
    _state = ViewState.Busy;
    notifyListeners();
  }

  setStateIdle() {
    _state = ViewState.Idle;
    notifyListeners();
  }

  setStateError() {
    _state = ViewState.Error;
    notifyListeners();
  }
}
