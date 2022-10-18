import '../../models/responses/number_trivia_response.dart';
import '../app_service_client/app_service_client.dart';

abstract class RemoteDataSource {
  Future<NumberTriviaResponse> getRandomNumberTrivia();
  Future<NumberTriviaResponse> getConcreteNumberTrivia(int number);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<NumberTriviaResponse> getRandomNumberTrivia() async {
    return await _appServiceClient.getRandomNumberTrivia();
  }

  @override
  Future<NumberTriviaResponse> getConcreteNumberTrivia(int number) async {
    return await _appServiceClient.getConcreteNumberTrivia(number);
  }
}
