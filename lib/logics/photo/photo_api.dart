import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'dart:io';

class PhotoAPI {
  PhotoModel data = PhotoModel();

  Future<String> getImage() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    final File compressedImage = await FlutterNativeImage.compressImage(image.path, quality: 80);
    // data.path = compressedImage.path;
    return compressedImage.path;
  }

}

class PhotoModel {
  String path;
  PhotoModel({
    this.path
  });
}