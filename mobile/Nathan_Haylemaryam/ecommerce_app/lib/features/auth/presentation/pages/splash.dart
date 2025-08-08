import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_events.dart';
import '../bloc/auth_states.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the auth bloc
    final authBloc = context.read<AuthBloc>();
    authBloc.add(CheckAuthStatusEvent());

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is Unauthenticated) {
          Navigator.pushReplacementNamed(context, '/signin');
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash_bg.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Color.fromARGB(180, 72, 54, 255),
                BlendMode.darken,
              ),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.yellow, width: 2),
                  ),
                  child: const Text(
                    'ECOM',
                    style: TextStyle(
                      fontSize: 112.89,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(63, 81, 243, 1),
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'ECOMMERCE APP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.98,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}