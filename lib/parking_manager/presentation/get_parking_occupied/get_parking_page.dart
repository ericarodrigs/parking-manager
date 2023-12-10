import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_manager/parking_manager/presentation/get_parking_occupied/bloc/get_parking_occupied_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/get_parking_occupied/grid_view_parking.dart';
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
        title: const Text('Parking Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
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
                      color: Colors.deepPurple,
                    ),
                  ),
              loaded: (parking) =>
                  finalView = GridViewParking(parking: parking),
              error: () => finalView = const Center(child: Text('error')));
          return finalView;
        },
      ),
    );
  }
}
