import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/constants.dart';
import '../../models/responses/number_trivia_response.dart';

part 'app_service_client.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @GET('/random/trivia')
  Future<NumberTriviaResponse> getRandomNumberTrivia();

  @GET('/{number}')
  Future<NumberTriviaResponse> getConcreteNumberTrivia(@Path('number') int number);
}
