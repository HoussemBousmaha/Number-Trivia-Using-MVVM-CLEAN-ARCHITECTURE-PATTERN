import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../state_renderer/state_renderer_implementer.dart';

abstract class BaseViewModel extends ChangeNotifier with BaseViewModelInputs, BaseViewModelOutputs {
  final StreamController<FlowState> _inputStateStreamController = BehaviorSubject<FlowState>();

  @override
  void dispose() {
    _inputStateStreamController.close();
    super.dispose();
  }

  @override
  Sink<FlowState> get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStateStreamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs {
  void start(); // will be called while init of view model
  void dispose(); // will be called when view model dies

  Sink<FlowState> get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
