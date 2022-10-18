import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/requests/concrete_number_trivia_request.dart';

import '../../../../core/base/base_use_case.dart';
import '../../../../core/failure/failure.dart';

import '../entities/number_trivia_model.dart';
import '../repositories/repository.dart';

class ConcreteNumberTriviaUseCase extends BaseUseCase<ConcreteNumberTriviaUseCaseInput, NumberTriviaModel> {
  final Repository _repository;

  ConcreteNumberTriviaUseCase(this._repository);

  @override
  Future<Either<Failure, NumberTriviaModel>> execute(input) async {
    return await _repository.getConcreteNumberTrivia(
      ConcreteNumberTriviaRequest(number: input.number),
    );
  }
}

class ConcreteNumberTriviaUseCaseInput {
  final int number;
  ConcreteNumberTriviaUseCaseInput({required this.number});
}
