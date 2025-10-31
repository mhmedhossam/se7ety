import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/core/widgets/main_button.dart';

enum DialogIconType { success, info, error }

showLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    barrierColor: AppColors.greyColor.withValues(alpha: 0.5),
    context: context,
    builder: (_) {
      return Center(
        child: Lottie.asset("assets/images/loading.json", width: 100),
      );
    },
  );
}

showMyDialog(BuildContext context, String message, DialogIconType messageType) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(20),
            messageType == DialogIconType.error
                ? Icon(Icons.error_outline_sharp, size: 50)
                : messageType == DialogIconType.info
                ? Icon(Icons.info, size: 50)
                : Image.asset("assets/images/success.png", width: 50),
            Gap(30),
            SizedBox(
              height: 50,
              width: 200,
              child: Text(
                message,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: TextStyles.body.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkColor,
                ),
              ),
            ),
            Gap(30),
            MainButton(
              onPressed: () {
                Navigation.pop(context);
              },
              text: "Close",
              width: 150,
              height: 40,
              borderRadius: BorderRadius.circular(20),
              bgColor: AppColors.primaryColor,
              textColor: AppColors.backgroundColor,
            ),
            Gap(10),
          ],
        ),
      );
    },
  );
}
