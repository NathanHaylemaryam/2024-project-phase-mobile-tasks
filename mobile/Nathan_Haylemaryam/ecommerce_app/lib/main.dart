import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routes/app_rounter.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await di.init();
    runApp(const MyApp());
  } catch (error) {
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Initialization failed: $error')),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<ProductBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'eCommerce App',
        theme: ThemeData(primarySwatch: Colors.purple),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: '/',
      ),
    );
  }
}