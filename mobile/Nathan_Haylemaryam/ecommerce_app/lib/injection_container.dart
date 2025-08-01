import 'package:get_it/get_it.dart';

import 'core/platform/network_info.dart';
import 'core/utils/product_input_converter.dart';
import 'features/product/data/data_source/product_local_data_source.dart';
import 'features/product/data/data_source/product_local_data_source_impl.dart';
import 'features/product/data/data_source/product_remote_data_source.dart';
import 'features/product/data/data_source/product_remote_data_source_impl.dart';
import 'features/product/data/repositories implemntation/product_repository_impl.dart';
import 'features/product/domain/repository/product_repository.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

final sl  = GetIt.instance;

void init(){
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

// Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(() => ProductLocalDataSourceImpl(sharedPreferences: sl()));


// Repository
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
    networkInfo: sl(),
  ));
  // Utilities
  sl.registerLazySingleton(() => ProductInputConverter());


}