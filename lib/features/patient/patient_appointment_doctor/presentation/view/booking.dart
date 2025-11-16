import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/helper/convert_time.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/firebase_services/firebase_services.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/core/widgets/custom_text_field.dart';
import 'package:se7ety/core/widgets/dialogs.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/features/auth/data/models/doctor.dart';
import 'package:se7ety/features/doctor/home/data/models/appointment_model.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/doctor_container.dart';

class BookingScreen extends StatefulWidget {
  final Doctor doctorModel;

  const BookingScreen({super.key, required this.doctorModel});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final detailsController = TextEditingController();

  final dateTimeController = TextEditingController();
  final selectedHourController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<int> times = [];

  int selectedHour = -1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16),
          child: MainButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                if (selectedHourController.text.isEmpty) {
                  showMyDialog(
                    context,
                    "من فضلك ادخل معاد الحجز ",
                    DialogIconType.info,
                  );
                } else {
                  AppointmentModel appointmentModel = AppointmentModel(
                    patientPhone: phoneController.text,
                    patientDesc: detailsController.text,
                    isComplete: false,
                    patientId: FirebaseAuth.instance.currentUser?.uid,
                    id: "",
                    date: dateTimeController.text,

                    docAddress: widget.doctorModel.address,
                    docId: widget.doctorModel.uid,
                    docName: widget.doctorModel.name,
                    patientName: nameController.text,
                    time: selectedHourController.text,
                  );
                  await FirebaseServices.setAppointment(
                    appointmentModel.toJson(),
                    context,
                  );
                }
              }
            },
            text: "تأكيد الحجز",
            bgColor: AppColors.primaryColor,
            textColor: AppColors.backgroundColor,
          ),
        ),
        appBar: AppBar(title: Text("احجز مع دكتورك")),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IgnorePointer(
                    ignoring: true,
                    child: DoctorContainer(doctorModel: widget.doctorModel),
                  ),
                  Gap(10),

                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "--أدخل بيانات الحجز --",
                      style: TextStyles.title,
                    ),
                  ),
                  Gap(20),
                  Text("اسم المريض"),
                  Gap(10),
                  CustomTextField(
                    hintText: "أدخل اسم المريض",
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك ادخل اسم المريض ";
                      }
                      return null;
                    },
                  ),
                  Gap(20),
                  Text("رقم الهاتف"),
                  Gap(10),

                  CustomTextField(
                    hintText: "أدخل رقم الهاتف",
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك ادخل رقم الهاتف  ";
                      }
                      return null;
                    },
                  ),
                  Gap(20),
                  Text("وصف الحالة"),
                  Gap(10),

                  CustomTextField(
                    hintText: "ادخل وصف الحاله",
                    controller: detailsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك ادخل وصف الحاله  ";
                      }
                      return null;
                    },
                    maxLine: 5,
                  ),
                  Gap(20),
                  Text("تاريخ الحجز"),
                  Gap(10),
                  CustomTextField(
                    hintText: "تاريخ الحجز",
                    controller: dateTimeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك ادخل تاريخ الحجز  ";
                      }
                      return null;
                    },
                    readOnly: true,
                    suffixIcon: ClipRRect(
                      child: IconButton(
                        onPressed: () async {
                          await chooseDate(context);
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.date_range,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Gap(20),
                  Text("وقت الحجز"),
                  Gap(10),
                  times.isNotEmpty
                      ? Wrap(
                          spacing: 8,
                          children: [
                            for (var time in times)
                              ChoiceChip(
                                label: Text(
                                  time < 10 ? "0$time:00" : "$time:00",
                                  style: TextStyles.body.copyWith(
                                    color: selectedHour == time
                                        ? AppColors.backgroundColor
                                        : AppColors.darkColor,
                                  ),
                                ),
                                selected: selectedHour == time,
                                labelPadding: EdgeInsets.all(1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                    color: AppColors.backgroundColor,
                                  ),
                                ),
                                onSelected: (_) {
                                  selectedHour = time;
                                  selectedHourController.text =
                                      "$selectedHour:00";
                                  setState(() {});
                                },
                                disabledColor: AppColors.backgroundColor,

                                checkmarkColor: AppColors.backgroundColor,
                                backgroundColor: AppColors.fillColor,
                                selectedColor: AppColors.primaryColor,
                              ),
                          ],
                        )
                      : Center(child: Text("أدخل التاريخ لعرض المواعيد ")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  chooseDate(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),

      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then((time) {
      if (time != null) {
        dateTimeController.text = DateFormat('yyyy-MM-dd').format(time);
        times = getDoctorHours(
          time,
          widget.doctorModel.openHour ?? "",
          widget.doctorModel.closeHour ?? "",
        );
      }
    });
  }
}

List<int> getDoctorHours(DateTime selectedDate, String start, String end) {
  int startDate = int.parse(start.split(':')[0].trim());
  int endDate = int.parse(end.split(':')[0].trim());
  List<int> availableTime = [];

  DateTime configureDateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  int differenceDate = selectedDate.difference(configureDateTime).inDays;

  for (int i = startDate; i < endDate; i++) {
    if (differenceDate > 0) {
      availableTime.add(i);
    } else {
      if (i > DateTime.now().hour) {
        availableTime.add(i);
      }
    }
  }
  return availableTime;
}
