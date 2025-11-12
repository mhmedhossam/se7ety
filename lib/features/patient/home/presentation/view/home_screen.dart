import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/firebase_services/firebase_services.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/app_fonts.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/core/widgets/custom_text_field.dart';
import '../widgets/custom_title.dart';
import '../widgets/list_view_builder_specialization_cards.dart';
import '../widgets/list_view_top_rate_builder.dart';

class HomeScreen extends StatelessWidget {
  var searchController = TextEditingController();
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "صِــحَّتـي",
          style: TextStyles.title.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: AppColors.darkColor,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_active)),
        ],
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16),
                child: RichText(
                  text: TextSpan(
                    style: TextStyles.title.copyWith(
                      fontFamily: AppFonts.cairoFamily,
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(text: "مرحبا, "),
                      TextSpan(
                        text: FirebaseServices().displayName,
                        style: TextStyles.title.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),

                      WidgetSpan(
                        alignment: PlaceholderAlignment.top,

                        child: Icon(
                          Icons.waving_hand,
                          color: AppColors.primaryColor,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 15),
                child: Text(
                  "احجز الأن وكن جزءًا من رحلتك الصحية",
                  style: TextStyles.subHeadline,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyColor.withValues(alpha: 0.4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: CustomTextField(
                  hintText: "ابحث عن دكتور",
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  cursorColor: AppColors.primaryColor,
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      Navigation.push(
                        context,
                        Routes.searchResultScreen,
                        value,
                      );
                    }
                  },
                  onTapOutside: (_) {
                    FocusScope.of(context).unfocus();
                  },
                  suffixIcon: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (searchController.text.isNotEmpty) {
                          Navigation.push(
                            context,
                            Routes.searchResultScreen,
                            searchController.text,
                          );
                        }
                      },
                      icon: Icon(
                        Icons.search,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
              CustomTitle(title: "التخصصات "),

              SizedBox(
                height: 200,
                child: ListViewBuilderSpecializationCards(),
              ),
              CustomTitle(title: "الأعلى تقييماٌ "),
              ListViewTopRateBuilder(),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
