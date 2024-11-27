import 'dart:async';

import 'package:flutter/cupertino.dart';

class TextFieldStreamBloc {
  bool _obs = false;
  final _obsController = StreamController<bool>.broadcast();
  final _hasValueController = StreamController<bool>.broadcast();

  var textController = TextEditingController();
  Stream<bool> get obsStream => _obsController.stream;
  Stream<bool> get isHasValueStream => _hasValueController.stream;

  void setController(TextEditingController? ctrl) {
    if (ctrl != null) {
      textController = ctrl;
    }
  }

  void clearController() {
    onChanged(null);
    textController.clear();
  }

  void changedObs(bool val) {
    _obs = val;
    _obsController.sink.add(_obs);
  }

  void onChanged(String? val) {
    _hasValueController.sink.add(val?.trim().isNotEmpty ?? false);
  }

  void dispose() {
    _obsController.close();
    textController.dispose();
    _hasValueController.close();
  }
}
