import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';

class CustomContactListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  const CustomContactListTile({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        radius: 17,
        backgroundColor: AppColors.primaryColor,
        child: Icon(icon, color: AppColors.backgroundColor, size: 20),
      ),
    );
  }
}
