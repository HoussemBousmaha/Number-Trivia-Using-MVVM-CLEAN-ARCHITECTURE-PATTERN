import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/failure/error_handler.dart';
import '../../models/responses/number_trivia_response.dart';

abstract class LocalDataSource {
  NumberTriviaResponse getNumberTrivia(int number);

  void saveNumbersTriviaToCache(int number, String trivia);

  Future<void> clearCache();

  Future<void> removeFromCache(String key);
}

class LocalDataSourceImplementer extends LocalDataSource {
  final SharedPreferences _sharedPreferences;

  LocalDataSourceImplementer(this._sharedPreferences);

  @override
  NumberTriviaResponse getNumberTrivia(int number) {
    final trivia = _sharedPreferences.getString('$number');

    if (trivia == null) throw ErrorHandler.handle(DataSource.cacheError);

    final numberTriviaModel = NumberTriviaResponse(trivia);
    return numberTriviaModel;
  }

  @override
  void saveNumbersTriviaToCache(int number, String trivia) {
    _sharedPreferences.setString('$number', trivia);
  }

  @override
  Future<void> clearCache() async => await _sharedPreferences.clear();

  @override
  Future<void> removeFromCache(String key) async => await _sharedPreferences.remove(key);
}
