import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_manager/parking_manager/presentation/get_trucks/bloc/get_trucks_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/get_trucks/get_trucks_page.dart';
import 'package:parking_manager/parking_manager/presentation/register_truck/bloc/register_truck_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/register_truck/register_truck_page.dart';
import 'package:parking_manager/shared/injector.dart';

class AppRouter {
  static const root = '/';
  static const registerTruck = '/registerTruck';

  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: root,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: BlocProvider(
            create: (context) => injector<GetTrucksBloc>(),
            child: const HomePage(),
          ),
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
