import 'package:dartz/dartz.dart';

import '../../../../core/base/base_use_case.dart';
import '../../../../core/failure/failure.dart';
import '../entities/number_trivia_model.dart';
import '../repositories/repository.dart';

class RandomNumberTriviaUseCase extends BaseUseCase<void, NumberTriviaModel> {
  final Repository _repository;

  RandomNumberTriviaUseCase(this._repository);

  @override
  Future<Either<Failure, NumberTriviaModel>> execute(void input) async {
    return await _repository.getRandomNumberTrivia();
  }
}
