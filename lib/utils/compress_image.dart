import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<List<int>> compressImage({required XFile imageFile}) async {
  int quality = 100;
  Uint8List? compressedImageBytes;
  const int maxFileSize = 1000 * 1000;

  while (true) {
    compressedImageBytes = await FlutterImageCompress.compressWithFile(
      imageFile.path,
      quality: quality,
    );

    if (compressedImageBytes!.length <= maxFileSize) {
      break;
    }
    quality -= 5;

    if (quality <= 0) {
      break;
    }
  }
  return compressedImageBytes;
}
