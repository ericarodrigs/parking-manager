import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/shared/routes.dart';

class GridViewParking extends StatelessWidget {
  final List<ParkingEntity> parking;
  const GridViewParking({Key? key, required this.parking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(parking);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            ParkingEntity? parking = findParkingByPosition(index);
            return parking != null
                ? buildGridItem(context, index, parking)
                : buildGridItemEmpty(context, index);
          },
        ),
      ),
    );
  }

  ParkingEntity? findParkingByPosition(int position) {
    ParkingEntity? result;
    for (var park in parking) {
      if (park.vacancy == position) {
        result = park;
        break;
      }
    }
    return result;
  }

  Widget buildGridItem(
      BuildContext context, int index, ParkingEntity parkingEntity) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(
        AppRouter.registerParking,
        extra: {'vacancy': index, 'parkingEntity': parkingEntity},
      ),
      child: Card(
        color: Colors.red.withOpacity(0.5),
        child: Center(
          child: Text('Vacancy ${index + 1} occupied'),
        ),
      ),
    );
  }

  Widget buildGridItemEmpty(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(
        AppRouter.registerParking,
        extra: {'vacancy': index, 'parkingEntity': null},
      ),
      child: Card(
        color: Colors.deepPurple.withOpacity(0.5),
        child: Center(
          child: Text('Vacancy ${index + 1} free'),
        ),
      ),
    );
  }
}
