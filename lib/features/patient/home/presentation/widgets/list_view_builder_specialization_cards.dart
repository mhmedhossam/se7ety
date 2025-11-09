import 'package:flutter/material.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/features/auth/data/models/specializations.dart';
import 'package:se7ety/features/patient/home/data/models/colors_list.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/specialization_card_widget.dart';

class ListViewBuilderSpecializationCards extends StatelessWidget {
  const ListViewBuilderSpecializationCards({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: specializations.length,
      itemBuilder: (context, i) {
        return SpecializationCardWidget(
          primary: colors[i % colors.length].primaryColor,
          light: colors[i % colors.length].lightColor,
          specializationText: specializations[i],
          onTap: () {
            Navigation.push(
              context,
              Routes.specializationSearchScreen,
              specializations[i],
            );
          },
          // specializationModel: ,
        );
      },
    );
  }
}
