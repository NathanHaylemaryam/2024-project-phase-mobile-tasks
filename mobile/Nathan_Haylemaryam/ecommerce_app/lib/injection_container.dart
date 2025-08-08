
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/network_info.dart';
import 'features/auth/data/data_source/auth_local_data_source.dart';
import 'features/auth/data/data_source/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repo_impl.dart';
import 'features/auth/data/repositories/reposotory_implmentaion.dart';
import 'features/auth/domain/repository/repository.dart';
import 'features/auth/domain/usecases/check_auth_status.dart';
import 'features/auth/domain/usecases/get_current_user.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/domain/usecases/logout.dart';
import 'features/auth/domain/usecases/signup.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/product/data/data_source/product_local_data_source.dart';
import 'features/product/data/data_source/product_local_data_source_impl.dart';
import 'features/product/data/data_source/product_remote_data_source.dart';
import 'features/product/data/data_source/product_remote_data_source_impl.dart';
import 'features/product/data/repositories implemntation/product_repository_impl.dart';
import 'features/product/domain/repository/product_repository.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());

  // Core
  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(connectivity: sl()),
  );

  // Auth
  _initAuthDependencies();

  // Product
  _initProductDependencies();
}

void _initAuthDependencies() {
  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => SignUp(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => CheckAuthStatus(sl()));

  // Bloc
  sl.registerFactory(() => AuthBloc(
    login: sl(),
    signUp: sl(),
    logout: sl(),
    getCurrentUser: sl(),
    checkAuthStatus: sl(),
  ));
}

void _initProductDependencies() {
  // Data Sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
        () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repository
  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Bloc
  sl.registerFactory(() => ProductBloc(sl()));
}