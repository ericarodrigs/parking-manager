import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_manager/parking_manager/presentation/get_history/bloc/get_history_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/get_history/get_history_page.dart';
import 'package:parking_manager/parking_manager/presentation/get_parking_occupied/bloc/get_parking_occupied_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/get_parking_occupied/get_parking_page.dart';
import 'package:parking_manager/parking_manager/presentation/register_parking/bloc/register_parking_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/register_parking/register_page.dart';
import 'package:parking_manager/parking_manager/presentation/update_parking/bloc/update_parking_bloc.dart';
import 'package:parking_manager/injector.dart';

class AppRouter {
  static const root = '/';
  static const registerParking = '/registerParking';
  static const history = '/history';

  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: root,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: BlocProvider(
            create: (context) => injector<GetParkingOccupiedBloc>()
              ..add(const GetAllParkingOccupiedEvent()),
            child: const HomePage(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: registerParking,
        pageBuilder: (context, state) {
          final registerBloc = injector<RegisterParkingBloc>();
          final updateBloc = injector<UpdateParkingBloc>();

          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return CustomTransitionPage(
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: registerBloc),
                BlocProvider.value(value: updateBloc),
              ],
              child: RegisterPage(
                vacancy: args['vacancy']!,
                parkingEntity: args['parkingEntity'],
              ),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: history,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: BlocProvider(
            create: (context) => injector<GetHistoryBloc>()
              ..add(GetAllHistoryEvent(getCurrentDate())),
            child: const GetHistoryPage(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
    ],
  );

  static String getCurrentDate() =>
      DateTime.now().toLocal().toIso8601String().split('T')[0];

  static GoRouter get router => _router;
}
