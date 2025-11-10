import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/services/firebase_services/firebase_services.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/textstyles.dart';
import 'package:se7ety/core/widgets/custom_text_field.dart';
import 'package:se7ety/core/widgets/no_search_widget.dart';
import 'package:se7ety/features/patient/home/data/models/doctor_model.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/doctor_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchDoctor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ابحث عن دكتور")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: Offset(4, 3),
                    color: AppColors.darkColor.withValues(alpha: 0.18),
                  ),
                ],
              ),
              child: CustomTextField(
                hintText: "البحث",
                controller: searchDoctor,
                suffixIcon: Icon(Icons.search),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),

            StreamBuilder(
              stream: FirebaseServices.searchStreamDoctor(searchDoctor.text),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (searchDoctor.text.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                      child: NoSearchWidget(text: "قم بالبحث عن اسم الدكتور"),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, i) {
                          return DoctorContainer(
                            doctorModel: DoctorModel.fromJson(
                              snapshot.data?.docs[i].data(),
                            ),
                            onTap: () {},
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: LottieBuilder.asset(
                      "assets/images/loading.json",
                      height: 50,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
