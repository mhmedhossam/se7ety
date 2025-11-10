import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';

class SettingListTile extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final IconData leadingIcon;
  const SettingListTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(20),
      ),

      child: ListTile(
        onTap: onTap,
        trailing: Icon(Icons.arrow_forward_ios),
        leading: Icon(leadingIcon),
        title: Text(
          title,
          style: TextStyles.small.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
