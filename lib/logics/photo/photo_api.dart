import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_native_image/flutter_native_image.dart';

class PhotoAPI {
  Future<String> getImage() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.camera);
    final File compressedImage = await FlutterNativeImage.compressImage(image.path, quality: 80, percentage: 100);
    return compressedImage.path;
  }
}