import 'dart:async';

import 'package:rxdart/subjects.dart';

import '../../../../../core/base/base_view_model.dart';
import '../../../../../core/state_renderer/state_renderer.dart';
import '../../../../../core/state_renderer/state_renderer_implementer.dart';
import '../../../domain/usecases/concrete_number_trivia_use_case.dart';
import '../../../domain/usecases/random_number_trivia_use_case.dart';

abstract class HomeViewModelInputs {
  Future<void> getConcreteNumberTrivia(int number);
  Future<void> getRandomNumberTrivia();
}

abstract class HomeViewModelOutputs {
  Stream get outputNumberTrivia;
}

class HomeViewModel extends BaseViewModel with HomeViewModelInputs, HomeViewModelOutputs {
  final StreamController _numberTriviaStreamController = BehaviorSubject();

  final RandomNumberTriviaUseCase _randomNumberTriviaUseCase;
  final ConcreteNumberTriviaUseCase _concreteNumberTriviaUseCase;
  HomeViewModel(this._randomNumberTriviaUseCase, this._concreteNumberTriviaUseCase);

  @override
  Future<void> getRandomNumberTrivia() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    (await _randomNumberTriviaUseCase.execute(null)).fold(
      (failure) {
        inputState.add(ErrorState(stateRendererType: StateRendererType.popupErrorState, message: failure.message));
      },
      (randomNumberTrivia) {
        _numberTriviaStreamController.add(randomNumberTrivia);
        inputState.add(ContentState());
      },
    );
  }

  @override
  Future<void> getConcreteNumberTrivia(int number) async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    final input = ConcreteNumberTriviaUseCaseInput(number: number);

    (await _concreteNumberTriviaUseCase.execute(input)).fold(
      (failure) {
        inputState.add(ErrorState(stateRendererType: StateRendererType.popupErrorState, message: failure.message));
      },
      (concreteNumberTrivia) {
        _numberTriviaStreamController.add(concreteNumberTrivia);
        inputState.add(ContentState());
      },
    );
  }

  @override
  void start() async => await getRandomNumberTrivia();

  @override
  Stream get outputNumberTrivia {
    return _numberTriviaStreamController.stream.map((concreteNumberTrivia) => concreteNumberTrivia);
  }
}
