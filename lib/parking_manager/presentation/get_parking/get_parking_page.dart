import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/presentation/get_parking/bloc/get_parking_bloc.dart';
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
        title: const Text('Parking Manager'),
      ),
      body: BlocBuilder<GetParkingBloc, GetParkingState>(
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
            loaded: (parking) => finalView = GridViewParking(parking: parking),
            error: () => finalView = const Center(child: Text('error')));
        return finalView;
      }),
    );
  }
}

class GridViewParking extends StatelessWidget {
  final List<ParkingEntity> parking;
  const GridViewParking({Key? key, required this.parking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => GoRouter.of(context).push(
                  AppRouter.registerParking,
                  extra: {
                    'vacancy': (index + 1),
                  },
                ),
                child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.deepPurple.withOpacity(0.5),
                  child: Center(
                    child: Text('Vaga: ${index + 1} - Livre'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
