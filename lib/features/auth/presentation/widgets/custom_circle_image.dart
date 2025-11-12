import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';

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
    return InkWell(
      borderRadius: BorderRadius.circular(30),
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
