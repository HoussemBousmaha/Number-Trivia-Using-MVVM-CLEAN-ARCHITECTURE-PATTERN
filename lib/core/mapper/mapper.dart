import '../../features/number_trivia/data/models/responses/number_trivia_response.dart';
import '../../features/number_trivia/domain/entities/number_trivia_model.dart';

const empty = '';

extension OrEmptyString on String? {
  String orEmpty() => this ?? empty;
}

extension NumberTriviaResponseMapper on NumberTriviaResponse? {
  NumberTriviaModel toDomain() {
    return NumberTriviaModel(trivia: this?.trivia?.orEmpty() ?? empty);
  }
}
