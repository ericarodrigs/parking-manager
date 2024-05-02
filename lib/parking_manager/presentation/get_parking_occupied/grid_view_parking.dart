import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/shared/routes/routes.dart';
import 'package:parking_manager/shared/themes/app_colors.dart';
import 'package:parking_manager/shared/themes/app_text_styles.dart';

class GridViewParking extends StatelessWidget {
  final List<ParkingEntity> parking;
  const GridViewParking({Key? key, required this.parking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 21,
          itemBuilder: (BuildContext context, int index) {
            ParkingEntity? parking = findParkingByPosition(index);
            return buildGridItem(context, index, parking);
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
      BuildContext context, int index, ParkingEntity? parkingEntity) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(
        AppRouter.registerParking,
        extra: {'vacancy': index, 'parkingEntity': parkingEntity},
      ),
      child: Card(
        color:
            parkingEntity != null ? AppColors.redLight : AppColors.primaryLight,
        child: Center(
          child: Text(
            parkingEntity != null
                ? 'Vacancy ${index + 1} \nOccupied'
                : 'Vacancy ${index + 1} \nFree',
            style: AppTextStyles.medium14white(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
