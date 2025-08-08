import 'package:flutter/material.dart';

// Auth Screens
import '../../features/auth/presentation/pages/home_screen.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/pages/splash.dart';


import '../../features/product/presentation/pages/ product_list_page.dart';
import '../../features/product/presentation/pages/add_product_page.dart';
import '../../features/product/presentation/pages/product_detail_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String home = '/home';
  static const String productList = '/product';
  static const String addProduct = '/add-product';
  static const String productDetail = '/product-detail';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashScreen());
      case signIn:
        return _buildRoute(const SignInScreen());
      case signUp:
        return _buildRoute(const SignUpScreen());
      case home:
        return _buildRoute(const HomeScreen());
      case productList:
        return _buildRoute( ProductListPage());
      case addProduct:
        return _buildRoute(AddProductPage());
      case productDetail:
        final productId = settings.arguments as String;
        return _buildRoute(ProductDetailPage(productId: productId));
      default:
        return _buildRoute(
          const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }

  static MaterialPageRoute<T> _buildRoute<T>(Widget widget) {
    return MaterialPageRoute<T>(
      builder: (_) => widget,
      settings: RouteSettings(name: widget.toStringShort()),
    );
  }
}