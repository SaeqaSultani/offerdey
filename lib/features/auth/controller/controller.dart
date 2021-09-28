import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/util/bloc/profile_pic/profilepic_bloc.dart';
import '../bloc/document/document_bloc.dart';

class ImagePickerController {
  static final ImagePickerController _controller =
      ImagePickerController._internal();

  final ImagePicker _picker = ImagePicker();

  factory ImagePickerController() {
    return _controller;
  }

  ImagePickerController._internal();

  Future<File?> _compressImage(File orginalFile, String newFileName) async {
    final Directory dir = await getApplicationDocumentsDirectory();

    File? compressedImage;

    compressedImage = await FlutterImageCompress.compressAndGetFile(
      orginalFile.path,
      '${dir.path}/$newFileName.jpg',
      quality: 100 * 1900000 ~/ orginalFile.readAsBytesSync().lengthInBytes,
    );

    return compressedImage;
  }

  Future<void> pickImage({required BuildContext context}) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final Directory dir = await getApplicationDocumentsDirectory();

      final File newImage =
          await File(image.path).copy('${dir.path}/profilePic.png');

      final int imageBytesLength = newImage.readAsBytesSync().lengthInBytes;

      File? compressedImage;

      if (imageBytesLength > 1900000) {
        compressedImage =
            await _compressImage(newImage, 'profilePicCompressed');
      }

      BlocProvider.of<ProfilePicBloc>(context).add(
        SetProfilePic(
            compressedImage != null ? compressedImage.path : newImage.path),
      );
    }
  }

  Future<void> pickLicenceFront({required BuildContext context}) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    print('licence');
    print(image);

    if (image != null) {
      final Directory dir = await getApplicationDocumentsDirectory();

      final File newImage =
          await File(image.path).copy('${dir.path}/licenceFront.jpg');

      final int imageBytesLength = newImage.readAsBytesSync().lengthInBytes;

      File? compressedImage;

      if (imageBytesLength > 1900000) {
        compressedImage =
            await _compressImage(newImage, 'licenceFrontCompressed');
      }

      BlocProvider.of<DocumentBloc>(context).add(
        SetLicenceFront(
            compressedImage != null ? compressedImage.path : newImage.path),
      );
    }
  }

  Future<void> pickLicenceBack({required BuildContext context}) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    print('licence');
    print(image);

    if (image != null) {
      final Directory dir = await getApplicationDocumentsDirectory();

      final File newImage =
          await File(image.path).copy('${dir.path}/storeLicence.jpg');

      final int imageBytesLength = newImage.readAsBytesSync().lengthInBytes;

      File? compressedImage;

      if (imageBytesLength > 1900000) {
        compressedImage =
            await _compressImage(newImage, 'licenceBackCompressed');
      }

      BlocProvider.of<DocumentBloc>(context).add(
        SetLicenceBack(
            compressedImage != null ? compressedImage.path : newImage.path),
      );
    }
  }

  Future<void> pickCnicFront({required BuildContext context}) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    print('cnic front');
    print(image);
    if (image != null) {
      final Directory dir = await getApplicationDocumentsDirectory();

      final File newImage =
          await File(image.path).copy('${dir.path}/cnicFront.jpg');

      final int imageBytesLength = newImage.readAsBytesSync().lengthInBytes;

      File? compressedImage;

      if (imageBytesLength > 1900000) {
        compressedImage =
            await _compressImage(newImage, 'licenceFrontCompressed');
      }

      BlocProvider.of<DocumentBloc>(context).add(
        SetCnicFront(
            compressedImage != null ? compressedImage.path : newImage.path),
      );
    }
  }

  Future<void> pickCnicBack({required BuildContext context}) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    print('cnic back');
    print(image);
    if (image != null) {
      final Directory dir = await getApplicationDocumentsDirectory();

      final File newImage =
          await File(image.path).copy('${dir.path}/cnicBack.jpg');

      final int imageBytesLength = newImage.readAsBytesSync().lengthInBytes;

      File? compressedImage;

      if (imageBytesLength > 1900000) {
        compressedImage =
            await _compressImage(newImage, 'licenceFrontCompressed');
      }

      BlocProvider.of<DocumentBloc>(context).add(
        SetCnicBack(
            compressedImage != null ? compressedImage.path : newImage.path),
      );
    }
  }
}
