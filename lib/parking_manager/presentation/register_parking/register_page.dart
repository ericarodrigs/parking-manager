import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart';
import 'package:parking_manager/parking_manager/presentation/register_parking/bloc/register_parking_bloc.dart';
import 'package:parking_manager/parking_manager/presentation/update_parking/bloc/update_parking_bloc.dart';
import 'package:parking_manager/shared/routes/routes.dart';
import 'package:parking_manager/shared/themes/app_colors.dart';
import 'package:parking_manager/shared/themes/app_text_styles.dart';
import 'package:parking_manager/shared/widgets/e_primary_button.dart';
import 'package:parking_manager/shared/widgets/e_text_form_field.dart';
import 'package:date_time_picker/date_time_picker.dart';

class RegisterPage extends StatefulWidget {
  final ParkingEntity? parkingEntity;
  final int vacancy;
  const RegisterPage({
    super.key,
    required this.vacancy,
    this.parkingEntity,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController plateController = MaskedTextController(
        mask: 'AAA-0*00', text: widget.parkingEntity?.plate);
    TextEditingController checkinTimeController = TextEditingController(
        text: widget.parkingEntity?.checkinTime ??
            DateTime.now().toIso8601String());
    TextEditingController checkoutTimeController =
        TextEditingController(text: widget.parkingEntity?.checkoutTime);
    ParkingEntity parking;

    return Scaffold(
      appBar: AppBar(
        title: widget.parkingEntity == null
            ? Text(
                'Register',
                style: AppTextStyles.bold24black(),
              )
            : Text(
                'Update',
                style: AppTextStyles.bold24black(),
              ),
        automaticallyImplyLeading: true,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<RegisterParkingBloc, RegisterParkingState>(
        listener: (context, state) {
          state.whenOrNull(
            success: () {
              showSnackBar(context, "Added successfully");
              GoRouter.of(context).pushReplacement(AppRouter.root);
            },
          );
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ETextFormField(
                    labelText: 'Plate',
                    controller: plateController,
                    onChanged: (value) {
                      plateController.text = value.toUpperCase();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'The plate can not be empty.';
                      }
                      if (value.length < 7) {
                        return 'The plate is invalid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DateTimePicker(
                      type: DateTimePickerType.dateTime,
                      dateMask: 'dd/MM/yyyy - HH:mm',
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2025),
                      decoration: InputDecoration(
                        icon: const Icon(Icons.event),
                        labelText: 'Entry date and hour',
                        errorStyle: AppTextStyles.bold16red(),
                      ),
                      controller: checkinTimeController,
                      readOnly: (widget.parkingEntity != null),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DateTimePicker(
                      type: DateTimePickerType.dateTime,
                      dateMask: 'dd/MM/yyyy - HH:mm',
                      firstDate: DateTime.parse(checkinTimeController.text),
                      lastDate: DateTime(2025),
                      decoration: InputDecoration(
                        icon: const Icon(Icons.event),
                        labelText: 'Exit date and hour',
                        errorStyle: AppTextStyles.bold16red(),
                      ),
                      controller: checkoutTimeController,
                      initialTime: TimeOfDay.fromDateTime(
                          DateTime.parse(checkinTimeController.text)),
                      validator: (value) {
                        if (checkoutTimeController.text.isNotEmpty) {
                          if (DateTime.parse(checkoutTimeController.text)
                              .isBefore(
                                  DateTime.parse(checkinTimeController.text))) {
                            return 'Must be after checkin';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  ETextFormField(
                    labelText: 'Vacancy',
                    enabled: false,
                    initialValue: widget.parkingEntity != null
                        ? (widget.parkingEntity!.vacancy + 1).toString()
                        : (widget.vacancy + 1).toString(),
                  ),
                  const Spacer(),
                  widget.parkingEntity == null
                      ? EPrimaryButton(
                          title: 'Save',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              parking = ParkingEntity(
                                plate: plateController.text.trim(),
                                checkinTime: checkinTimeController.text,
                                checkoutTime: checkoutTimeController.text,
                                vacancy: widget.vacancy,
                              );
                              context.read<RegisterParkingBloc>().add(
                                    RegisterNewParkingEvent(parking),
                                  );
                            }
                          },
                        )
                      : BlocConsumer<UpdateParkingBloc, UpdateParkingState>(
                          listener: (context, state) {
                          state.whenOrNull(
                            success: () {
                              showSnackBar(context, "Updated successfully");
                              GoRouter.of(context)
                                  .pushReplacement(AppRouter.root);
                            },
                          );
                        }, builder: (context, state) {
                          return EPrimaryButton(
                            title: 'Edit',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                parking = ParkingEntity(
                                  id: widget.parkingEntity!.id,
                                  plate: plateController.text.trim(),
                                  checkinTime: checkinTimeController.text,
                                  checkoutTime: checkoutTimeController.text,
                                  vacancy: widget.vacancy,
                                );
                                context.read<UpdateParkingBloc>().add(
                                      UpdateNewParkingEvent(parking),
                                    );
                              }
                            },
                          );
                        }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
