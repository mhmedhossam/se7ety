import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';

class AccountSettingCard extends StatelessWidget {
  final String title;
  final String desc;
  final void Function() onTap;
  const AccountSettingCard({
    super.key,
    required this.title,
    required this.desc,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(12),
      ),

      child: ListTile(
        onTap: onTap,
        title: Text(title, style: TextStyles.title.copyWith(fontSize: 16)),
        trailing: Container(
          alignment: Alignment.centerLeft,

          width: 150,
          child: Text(
            desc,
            style: TextStyles.body.copyWith(fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
