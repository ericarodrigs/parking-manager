import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_manager/parking_manager/domain/entities/truck_entity.dart';
import 'package:parking_manager/parking_manager/presentation/get_trucks/bloc/get_trucks_bloc.dart';
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
      body:
          BlocBuilder<GetTrucksBloc, GetTrucksState>(builder: (context, state) {
        state.when(
            initial: () => finalView = const GridViewTrucks(),
            loading: () => finalView = const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                ),
            loaded: (trucks) => {finalView = GridViewTrucks(trucks: trucks)},
            error: () => finalView = const Center(child: Text('error')));
        return finalView;
      }),
    );
  }
}

class GridViewTrucks extends StatelessWidget {
  final List<TruckEntity>? trucks;
  const GridViewTrucks({Key? key, this.trucks}) : super(key: key);

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
                onTap: () => GoRouter.of(context).go(AppRouter.registerTruck),
                child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.deepPurple.withOpacity(0.5),
                  child: Center(
                    child: (trucks != null)
                        ? Text('Vaga: ${index + 1} - ${trucks?[index].plate}')
                        : Text('Vaga: ${index + 1} - Livre'),
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
