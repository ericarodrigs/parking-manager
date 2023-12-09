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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            print(parking);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => GoRouter.of(context).push(
                  AppRouter.registerParking,
                  extra: {'vacancy': index, 'parkingEntity': null},
                ),
                child: Container(
                  width: 20,
                  height: 20,
                  color: readIsFreeParking(index, parking)
                      ? Colors.deepPurple.withOpacity(0.5)
                      : Colors.red.withOpacity(0.5),
                  child: Center(
                    child: readIsFreeParking(index, parking)
                        ? Text('Vaga: ${index + 1} - Livre - ${parking.length}')
                        : Text(
                            'Vaga: ${index + 1} - Ocupada - ${parking.length}'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool readIsFreeParking(int index, List<ParkingEntity> parking) {
    for (var element in parking) {
      if (element.vacancy == index && element.checkoutTime == null) {
        return false; //ocupada
      }
    }
    return true;
  }
}
