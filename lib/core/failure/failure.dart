import 'error_handler.dart';

class Failure {
  final int code;
  final String message;
  Failure({required this.code, required this.message});
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(code: ResponseCode.defaultError, message: ResponseMessage.defaultError);
}
