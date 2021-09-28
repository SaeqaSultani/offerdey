import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/bloc/profile_pic/profilepic_bloc.dart';
import '../controller/controller.dart';

class ImagePlaceHolder extends StatelessWidget {
  const ImagePlaceHolder();

  @override
  Widget build(BuildContext context) {
    final ImagePickerController _imagePickerController =
        ImagePickerController();

    return BlocBuilder<ProfilePicBloc, ProfilePicState>(
      builder: (context, state) {
        return ClipOval(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.background,
              image: (state is ProfilePicSet)
                  ? DecorationImage(
                      image: MemoryImage(
                          File(state.profilePictureUrl!).readAsBytesSync()),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              color: const Color(0x990E2F4A),
              height: 40.h,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    await _imagePickerController.pickImage(context: context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 24.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
