import 'dart:io';

import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/helper/upload_image.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/core/widgets/custom_text_field.dart';
import 'package:se7ety/core/widgets/dialogs.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/features/auth/data/models/specializations.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_states.dart';

import '../widgets/custom_align_text.dart';

class DrCompleteRegisterScreen extends StatefulWidget {
  const DrCompleteRegisterScreen({super.key});

  @override
  State<DrCompleteRegisterScreen> createState() =>
      _DrCompleteRegisterScreenState();
}

class _DrCompleteRegisterScreenState extends State<DrCompleteRegisterScreen> {
  Future<String?> getImagePath(File? file) async {
    String? path = await uploadImageToCloudinary(file!);
    print(path);
    return path;
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(cubit: cubit),
      appBar: AppBar(
        title: Text(
          "إكمال عملية التسجيل ",
          style: TextStyles.title.copyWith(color: AppColors.backgroundColor),
        ),
      ),
      body: BlocListener<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is AuthSucceedState) {
            Navigation.pop(context);
          } else if (state is AuthLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuthFailureState) {
            Navigation.pop(context);

            showMyDialog(
              context,
              state.message ?? "error please try again",
              DialogIconType.error,
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(17),
              child: Form(
                key: cubit.form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomCircleImage(media: media, cubit: cubit),
                    Gap(10),

                    CustomAlignText(text: "التخصص"),
                    Gap(10),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 20, 0),

                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.fillColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        borderRadius: BorderRadius.zero,
                        hint: Text("ادخل التخصص"),
                        underline: SizedBox.shrink(),
                        value: cubit.specializationController.text.isEmpty
                            ? null
                            : cubit.specializationController.text,
                        items: List.generate(specializations.length, (i) {
                          return DropdownMenuItem<String>(
                            value: specializations[i],
                            child: Text(specializations[i]),
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              cubit.specializationController.text = value;
                            }
                          });
                        },
                      ),
                    ),
                    Gap(10),

                    CustomAlignText(text: "نبذة تعريفية"),
                    Gap(10),

                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "قم بأدخال نبذه تعريفيه عنك";
                        }
                        return null;
                      },
                      minLine: 5,
                      maxLine: 7,
                      keyboardType: TextInputType.multiline,
                      hintText:
                          "سجل المعلومات الطبية العامه مثل تعليمك الاكاديمى وحبراتك السابقة ...",
                      controller: cubit.bioController,
                    ),
                    Gap(10),

                    Divider(),
                    Gap(10),
                    CustomAlignText(text: "عنوان العيادة"),
                    Gap(10),

                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "من فضلك قم بأدخال عنوان العياده";
                        }
                        return null;
                      },
                      hintText: "5 شارع مصدق - الدقى - الجيزة ",
                      controller: cubit.addressController,
                      keyboardType: TextInputType.streetAddress,
                    ),
                    Gap(20),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "ساعات العمل من",
                            style: TextStyles.title.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "إلى",
                            style: TextStyles.title.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(15),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "قم بأدخال ساعات العمل";
                              }
                              return null;
                            },
                            controller: cubit.openHourController,
                            readOnly: true,
                            suffixIcon: Icon(Icons.watch_later_outlined),
                            hintText: "PM 10:00",
                            onTap: () {
                              showCupertinoTimePicker(
                                context,
                                widgetRenderBox: null,
                                horizontalSpacing: media.width * 0.2,
                                offset: Offset(0, media.height * 0.2),
                                use24hFormat: false,
                                onTimeChanged: (time) {
                                  cubit.openHourController.text =
                                      "${time.hourOfPeriod}:${time.minute} ${time.period == DayPeriod.am ? "am" : "pm"}";
                                },
                              );
                            },
                          ),
                        ),

                        Gap(20),

                        Expanded(
                          child: CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return " مطلوب *";
                              }
                              return null;
                            },
                            onTap: () {
                              showCupertinoTimePicker(
                                horizontalSpacing: media.width * 0.2,
                                offset: Offset(0, media.height * 0.2),
                                use24hFormat: false,
                                context,
                                widgetRenderBox: null,
                                onTimeChanged: (time) {
                                  cubit.closeHourController.text =
                                      "${time.hourOfPeriod}:${time.minute} ${time.period == DayPeriod.am ? "am" : "pm"}";
                                },
                              );
                            },
                            readOnly: true,
                            suffixIcon: Icon(Icons.watch_later_outlined),
                            hintText: "PM 10:00",
                            controller: cubit.closeHourController,
                          ),
                        ),
                      ],
                    ),
                    Gap(10),

                    CustomAlignText(text: "رقم الهاتف 1 "),
                    Gap(10),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "أدخل رقم الهاتف ";
                        }
                        return null;
                      },
                      hintText: "20xxxxxxxxxxx+",
                      controller: cubit.phone1Controller,
                      keyboardType: TextInputType.phone,
                    ),
                    Gap(10),
                    CustomAlignText(text: "رقم الهاتف 2 ( احتيارى )"),
                    Gap(10),

                    CustomTextField(
                      hintText: "20xxxxxxxxxxx+",
                      controller: cubit.phone2Controller,
                      keyboardType: TextInputType.phone,
                    ),
                    Gap(30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SafeArea bottomNavigationBar({required AuthCubit cubit}) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
        child: MainButton(
          onPressed: () async {
            if (cubit.form.currentState!.validate()) {
              if (cubit.file != null &&
                  cubit.specializationController.text.isNotEmpty) {
                String? path = await uploadImageToCloudinary(cubit.file!);
                cubit.imagePath = path;
                cubit.registerCompleteData();
              } else {
                if (cubit.specializationController.text.isEmpty &&
                    cubit.imagePath == null) {
                  showMyDialog(
                    context,
                    " من فضلك قم بادخال التخصص والصورة ",
                    DialogIconType.info,
                  );
                } else if (cubit.file == null) {
                  showMyDialog(
                    context,
                    "من فضلك قم برفع الصورة ",
                    DialogIconType.info,
                  );
                } else if (cubit.specializationController.text.isEmpty) {
                  showMyDialog(
                    context,
                    "من فضلك أدخل التخصص ",
                    DialogIconType.info,
                  );
                } else {
                  showMyDialog(
                    context,
                    " من فضلك قم بادخال التخصص والصورة ",
                    DialogIconType.info,
                  );
                }
              }
            }
          },
          text: "التسجيل",
          bgColor: AppColors.primaryColor,
          textColor: AppColors.backgroundColor,
        ),
      ),
    );
  }
}

class CustomCircleImage extends StatefulWidget {
  const CustomCircleImage({
    super.key,
    required this.media,
    required this.cubit,
  });

  final Size media;
  final AuthCubit cubit;
  @override
  State<CustomCircleImage> createState() => _CustomCircleImageState();
}

class _CustomCircleImageState extends State<CustomCircleImage> {
  String? imagePath;
  File? file;

  Future<void> _pickImage() async {
    final pikedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pikedFile != null) {
      setState(() {
        imagePath = pikedFile.path;

        file = File(imagePath!);
        widget.cubit.file = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _pickImage();
      },
      child: Stack(
        children: [
          CircleAvatar(
            maxRadius: 50,
            minRadius: 50,
            backgroundColor: AppColors.backgroundColor,
            backgroundImage: imagePath != null
                ? FileImage(file!)
                : AssetImage(AppImages.doc),
          ),
          PositionedDirectional(
            end: widget.media.width * 0.17,
            bottom: 0,
            child: CircleAvatar(
              backgroundColor: AppColors.backgroundColor,
              minRadius: 15,
              maxRadius: 20,
              child: Icon(Icons.camera_alt, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
