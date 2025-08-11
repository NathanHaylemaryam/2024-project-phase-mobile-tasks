import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// sl<AuthBloc>()
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../features/auth/presentation/pages/home_screen.dart';
import '../../../features/auth/presentation/pages/sign_in_screen.dart';
import '../../../features/auth/presentation/pages/sign_up_screen.dart';
import '../../../features/auth/presentation/pages/splash_screen.dart';

import '../../features/auth/injection_container.dart' as auth_di;
import '../../features/chat/injection_container.dart' as chat_di;
import '../../features/chat/presentation/bloc/chat/chat_bloc.dart';
import '../../features/chat/presentation/bloc/user/user_bloc.dart';
import '../../features/chat/presentation/pages/chat_detail_page.dart';
import '../../features/chat/presentation/pages/chat_list_page.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Splash screen
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => auth_di.sl<AuthBloc>()..add(GetUserEvent()),
            child: const EcomScreen(),
          ),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => auth_di.sl<AuthBloc>(),
            child: const SignInScreen(),
          ),
        );

      case '/signup':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => auth_di.sl<AuthBloc>(),
            child: const CreateAccountScreen(),
          ),
        );

      case '/home':
        // Expect userName and userEmail as arguments
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => auth_di.sl<AuthBloc>(),
            child: HomeScreen(
              userName: args['userName']!,
              userEmail: args['userEmail']!,
              userId: args['userId']!,
            ),
          ),
        );

      // ...Chat Routes

      case '/chatList':
        final String currentUserId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    chat_di.chatSl<ChatBloc>()..add(LoadChatsEvent()),
              ),
              BlocProvider(
                create: (_) =>
                    chat_di.chatSl<UserBloc>()..add(LoadUsersEvent()),
              ),
            ],
            child: ChatListScreen(currentUserId: currentUserId),
          ),
        );

      case '/chatDetail':
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ChatDetailScreen.withBloc(
            chatId: args['chatId'] as String,
            currentUserId: args['currentUserId'] as String,
            otherUserId: args['otherUserId'] as String,
            otherUserName: args['otherUserName'] as String,
          ),
        );
      // -------- PRODUCT ROUTES --------

      // case '/products':
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (_) =>
      //           product_di.sl<ProductBloc>()..add(const LoadAllProductEvent()),
      //       child: const RetrieveAllProductsPage(),
      //     ),
      //   );
      //
      // case '/detail':
      //   final String productId = settings.arguments as String;
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (_) =>
      //           product_di.sl<ProductBloc>()
      //             ..add(GetSingleProductEvent(productId)),
      //       child: ProductDetailsPage(productId: productId),
      //     ),
      //   );
      //
      // case '/create':
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (_) => product_di.sl<ProductBloc>(),
      //       child: const AddUpdateProductPage(isEditing: false),
      //     ),
      //   );
      //
      // case '/update':
      //   final Product product = settings.arguments as Product;
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (_) => product_di.sl<ProductBloc>(),
      //       child: AddUpdateProductPage(isEditing: true, product: product),
      //     ),
      //   );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
