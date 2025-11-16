import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/features/auth/data/models/doctor.dart';
import 'package:se7ety/features/auth/presentation/widgets/custom_align_text.dart';
import 'package:se7ety/features/patient/profile/presentation/widgets/custom_contact_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorDetails extends StatelessWidget {
  final Doctor doctorModel;
  const DoctorDetails({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("بيانات الدكتور")),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MainButton(
            onPressed: () {
              Navigation.push(context, Routes.bookingScreen, doctorModel);
            },
            text: "احجز موعد الأن",
            bgColor: AppColors.primaryColor,
            textColor: AppColors.backgroundColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      clipBehavior: Clip.antiAlias,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: doctorModel.image ?? "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, sds, url) => Icon(
                          CupertinoIcons.person_alt_circle_fill,
                          color: AppColors.primaryColor,
                          size: 100,
                        ),
                      ),
                    ),
                    Gap(30),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          doctorModel.name ?? "",
                          style: TextStyles.title.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Gap(0),
                        Text(doctorModel.specialization ?? ""),
                        Gap(10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("${doctorModel.rating}"),
                            Icon(Icons.star, color: Colors.amber, size: 20),
                          ],
                        ),

                        Gap(20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Gap(20),
                            doctorModel.phone1 != null
                                ? PhoneButton(
                                    icon: Icons.phone,
                                    num: "1",
                                    onTap: () {
                                      launchUrl(
                                        Uri.parse("tel:${doctorModel.phone1}"),
                                      );
                                    },
                                  )
                                : SizedBox.shrink(),
                            Gap(20),
                            doctorModel.phone2 != null ||
                                    doctorModel.phone2 != ""
                                ? PhoneButton(
                                    icon: Icons.phone,
                                    num: "2",
                                    onTap: () {
                                      launchUrl(
                                        Uri.parse("tel:${doctorModel.phone2}"),
                                      );
                                    },
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Gap(20),

                Text(
                  "نبذة تعريفية",
                  style: TextStyles.small.copyWith(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(20),
                Text(
                  doctorModel.bio ?? "",
                  style: TextStyles.small.copyWith(color: AppColors.darkColor),
                ),
                Gap(20),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.fillColor,
                  ),
                  child: Column(
                    children: [
                      CustomContactListTile(
                        title:
                            "open ${doctorModel.openHour ?? "00"} - close ${doctorModel.closeHour ?? "00"}   ",
                        icon: Icons.mail_rounded,
                      ),
                      CustomContactListTile(
                        title: doctorModel.address ?? "لم يضاف",
                        icon: Icons.phone,
                      ),
                    ],
                  ),
                ),
                Divider(),
                Gap(20),
                Text(
                  "معلومات الاتصال,",
                  style: TextStyles.small.copyWith(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(20),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.fillColor,
                  ),
                  child: Column(
                    children: [
                      CustomContactListTile(
                        title: doctorModel.email ?? "",
                        icon: Icons.mail_rounded,
                      ),
                      doctorModel.phone1 != null
                          ? CustomContactListTile(
                              title: doctorModel.phone1 ?? "لم يضاف",
                              icon: Icons.phone,
                            )
                          : SizedBox.shrink(),
                      doctorModel.phone2 != null
                          ? CustomContactListTile(
                              title: doctorModel.phone2 ?? "لم يضاف",
                              icon: Icons.phone,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneButton extends StatelessWidget {
  final String num;
  final IconData icon;
  final void Function() onTap;
  const PhoneButton({
    super.key,
    required this.num,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.fillColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text(num), Icon(icon)],
        ),
      ),
    );
  }
}
