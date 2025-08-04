// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/network_info.dart';
import 'core/routes/app_rounter.dart';
import 'features/product/data/data_source/product_local_data_source.dart';
import 'features/product/data/data_source/product_local_data_source_impl.dart';
import 'features/product/data/data_source/product_remote_data_source.dart';
import 'features/product/data/data_source/product_remote_data_source_impl.dart';
import 'features/product/data/repositories implemntation/product_repository_impl.dart';
import 'features/product/domain/repository/product_repository.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/bloc/product_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize required packages
  final sharedPreferences = await SharedPreferences.getInstance();
  final connectivity = Connectivity();

  runApp(MyApp(
    sharedPreferences: sharedPreferences,
    connectivity: connectivity,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  final Connectivity connectivity;
  final AppRouter _appRouter = AppRouter();

 MyApp({
    super.key,
    required this.sharedPreferences,
    required this.connectivity,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NetworkInfo>(
          create: (context) => NetworkInfoImpl(connectivity: connectivity),
        ),
        RepositoryProvider<ProductRemoteDataSource>(
          create: (context) => ProductRemoteDataSourceImpl(
            client: http.Client(),
          ),
        ),
        RepositoryProvider<ProductLocalDataSource>(
          create: (context) => ProductLocalDataSourceImpl(
            sharedPreferences: sharedPreferences,
          ),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepositoryImpl(
            remoteDataSource: RepositoryProvider.of<ProductRemoteDataSource>(context),
            localDataSource: RepositoryProvider.of<ProductLocalDataSource>(context),
            networkInfo: RepositoryProvider.of<NetworkInfo>(context),
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => ProductBloc(
          RepositoryProvider.of<ProductRepository>(context),
        )..add(LoadAllProductEvent()), // Load products immediately
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'eCommerce App',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: '/',        ),
      )
    );
  }
}