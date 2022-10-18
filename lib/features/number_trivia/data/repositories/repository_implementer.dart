import 'package:dartz/dartz.dart';

import '../../../../core/failure/error_handler.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/mapper/mapper.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domain/entities/number_trivia_model.dart';
import '../../domain/repositories/repository.dart';
import '../data_sources/local_data_source/local_data_source.dart';
import '../data_sources/remote_data_source/remote_data_source.dart';
import '../models/requests/concrete_number_trivia_request.dart';

class RepositoryImplementer extends Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImplementer(this._remoteDataSource, this._localDataSource, this._networkInfo);

  @override
  Future<Either<Failure, NumberTriviaModel>> getRandomNumberTrivia() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getRandomNumberTrivia();
        if (response.trivia != null) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(code: ApiInternalStatus.failure, message: ResponseMessage.defaultError));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, NumberTriviaModel>> getConcreteNumberTrivia(
    ConcreteNumberTriviaRequest concreteNumberTriviaRequest,
  ) async {
    try {
      // cache trivia
      final response = _localDataSource.getNumberTrivia(concreteNumberTriviaRequest.number);

      return Right(response.toDomain());
    } catch (err) {
      // call api
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getConcreteNumberTrivia(concreteNumberTriviaRequest.number);

          // check if response is success
          if (response.trivia != null) {
            // cache response to local cache
            _localDataSource.saveNumbersTriviaToCache(concreteNumberTriviaRequest.number, response.trivia!);
            // return reponse
            return Right(response.toDomain());
          } else {
            return Left(Failure(code: ApiInternalStatus.failure, message: ResponseMessage.defaultError));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }
}
