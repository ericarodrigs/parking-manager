import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_manager/parking_manager/presentation/pages/home_page.dart';
import 'package:parking_manager/parking_manager/presentation/register_truck/bloc/register_truck_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/register_truck/register_page.dart';
import 'package:parking_manager/shared/injector.dart';

class AppRouter {
  static const root = '/';
  static const registerTruck = '/registerTruck';

  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: root,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: registerTruck,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: BlocProvider(
            create: (context) => injector<RegisterTruckBloc>(),
            child: const RegisterPage(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
    ],
  );

  static GoRouter get router => _router;
}
