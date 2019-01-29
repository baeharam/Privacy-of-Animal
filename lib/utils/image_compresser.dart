import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<List<int>> compressImage(String assetName) async {
  return await FlutterImageCompress.compressAssetImage(
    assetName,
    minHeight: 300,
    minWidth: 300,
    quality: 50,
  );
}