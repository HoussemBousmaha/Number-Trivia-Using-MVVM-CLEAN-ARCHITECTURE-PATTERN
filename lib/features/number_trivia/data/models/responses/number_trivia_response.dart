import 'package:freezed_annotation/freezed_annotation.dart';

part 'number_trivia_response.g.dart';

@JsonSerializable()
class NumberTriviaResponse {
  @JsonKey(name: 'trivia')
  final String? trivia;
  NumberTriviaResponse(this.trivia);

  factory NumberTriviaResponse.fromJson(Map<String, dynamic> json) => _$NumberTriviaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NumberTriviaResponseToJson(this);
}
