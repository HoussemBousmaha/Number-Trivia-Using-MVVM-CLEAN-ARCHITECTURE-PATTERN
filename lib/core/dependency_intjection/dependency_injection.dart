import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/number_trivia/data/data_sources/app_service_client/app_service_client.dart';
import '../../features/number_trivia/data/data_sources/local_data_source/local_data_source.dart';
import '../../features/number_trivia/data/data_sources/remote_data_source/remote_data_source.dart';
import '../../features/number_trivia/data/repositories/repository_implementer.dart';
import '../../features/number_trivia/domain/repositories/repository.dart';
import '../../features/number_trivia/domain/usecases/concrete_number_trivia_use_case.dart';
import '../../features/number_trivia/domain/usecases/random_number_trivia_use_case.dart';
import '../../features/number_trivia/presentation/views/home/home_view_model.dart';
import '../dio_factory/dio_factory.dart';
import '../network_info/network_info.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // network info instance
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementer(Connectivity()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  // app service client
  final dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImplementer(instance()));

  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImplementer(instance()));

  // repository
  instance.registerLazySingleton<Repository>(
    () => RepositoryImplementer(instance<RemoteDataSource>(), instance<LocalDataSource>(), instance<NetworkInfo>()),
  );
}

void initHomeModule() {
  if (!GetIt.I.isRegistered<RandomNumberTriviaUseCase>()) {
    instance.registerFactory<RandomNumberTriviaUseCase>(() => RandomNumberTriviaUseCase(instance<Repository>()));
    instance.registerFactory<ConcreteNumberTriviaUseCase>(() => ConcreteNumberTriviaUseCase(instance<Repository>()));

    instance.registerFactory<HomeViewModel>(
      () => HomeViewModel(instance<RandomNumberTriviaUseCase>(), instance<ConcreteNumberTriviaUseCase>()),
    );
  }
}
