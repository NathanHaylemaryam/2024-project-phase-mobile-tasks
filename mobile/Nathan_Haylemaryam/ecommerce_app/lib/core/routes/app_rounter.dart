// lib/core/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/product/domain/entities/product.dart';

import '../../features/product/presentation/bloc/product_bloc.dart';
import '../../features/product/presentation/bloc/product_event.dart';
import '../../features/product/presentation/pages/ product_list_page.dart';
import '../../features/product/presentation/pages/add_product_page.dart';
import '../../features/product/presentation/pages/home_page.dart';
import '../../features/product/presentation/pages/product_detail_page.dart';
import '../../injection_container.dart';


class AppRouter {
  // lib/core/routes/app_router.dart
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ProductBloc>()..add(const LoadAllProductEvent()),
            child:  ProductListPage(),
          ),
        );

      case '/add-product':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ProductBloc>(),
            child:  AddProductPage(),
          ),
        );

      case '/product-detail':
        final String productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ProductBloc>()..add(GetProductEvent(productId)),
            child: ProductDetailPage(productId: productId),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}