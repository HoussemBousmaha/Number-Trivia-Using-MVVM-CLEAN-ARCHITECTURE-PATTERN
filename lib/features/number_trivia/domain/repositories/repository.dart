import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../data/models/requests/concrete_number_trivia_request.dart';
import '../entities/number_trivia_model.dart';

abstract class Repository {
  Future<Either<Failure, NumberTriviaModel>> getRandomNumberTrivia();
  Future<Either<Failure, NumberTriviaModel>> getConcreteNumberTrivia(
    ConcreteNumberTriviaRequest concreteNumberTriviaRequest,
  );
}
