import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_manager/parking_manager/presentation/get_parking/bloc/get_parking_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/get_parking/get_parking_page.dart';
import 'package:parking_manager/parking_manager/presentation/register_parking/bloc/register_parking_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/register_parking/register_page.dart';
import 'package:parking_manager/shared/injector.dart';

class AppRouter {
  static const root = '/';
  static const registerParking = '/registerParking';

  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: root,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: BlocProvider(
            create: (context) =>
                injector<GetParkingBloc>()..add(const GetAllParkingEvent()),
            child: const HomePage(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: registerParking,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: BlocProvider(
            create: (context) => injector<RegisterParkingBloc>(),
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
