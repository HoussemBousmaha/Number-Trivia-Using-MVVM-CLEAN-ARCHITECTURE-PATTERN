import 'package:dio/dio.dart';

import '../constants/constants.dart';

const String applicationJson = 'application/json';
const String contentType = 'content-type';
const String accept = 'accept';
const String authorization = 'authorization';
const String defaultLanguage = 'lanaguage';

class DioFactory {
  Future<Dio> getDio() async {
    // dio instance
    Dio dio = Dio();

    // time out
    const int timeOut = 60 * 1000; // one minute

    // get language

    // headers
    final Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: 'api-token',
    };

    // update dio options
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      headers: headers,
    );

    // if (kDebugMode) {
    //   dio.interceptors.add(
    //     PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true, maxWidth: 400),
    //   );
    // }

    return dio;
  }
}
