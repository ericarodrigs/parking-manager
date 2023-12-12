import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_manager/parking_manager/presentation/get_parking_occupied/bloc/get_parking_occupied_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/get_parking_occupied/grid_view_parking.dart';
import 'package:parking_manager/shared/app_colors.dart';
import 'package:parking_manager/shared/app_text_styles.dart';
import 'package:parking_manager/shared/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    late Widget finalView;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Parking Manager',
          style: AppTextStyles.bold24black(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => GoRouter.of(context).push(AppRouter.history),
          ),
        ],
      ),
      body: BlocBuilder<GetParkingOccupiedBloc, GetParkingOccupiedState>(
        builder: (context, state) {
          state.when(
            initial: () => finalView = const GridViewParking(
              parking: [],
            ),
            loading: () => finalView = const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
            loaded: (parking) => finalView = GridViewParking(parking: parking),
            error: () => finalView = Center(
              child: Text(
                'error',
                style: AppTextStyles.bold24black(),
              ),
            ),
          );
          return finalView;
        },
      ),
    );
  }
}
