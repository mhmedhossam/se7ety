import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/widgets/custom_text_field.dart';

import '../widgets/search_stream_list.dart';

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
        child: SingleChildScrollView(
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

              SearchStreamList(searchDoctor: searchDoctor),
            ],
          ),
        ),
      ),
    );
  }
}
