import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

Future<List<int>> compressImage({required XFile imageFile}) async {
  int quality = 100;
  Uint8List? compressedImageBytes;
  const int maxFileSize = 1024 * 1024;

  while (true) {
    compressedImageBytes = await FlutterImageCompress.compressWithFile(
      imageFile.path,
      quality: quality,
    );

    if (compressedImageBytes!.length <= maxFileSize) {
      break;
    }

    // Decrease the quality for further compression attempts
    quality -= 5;

    if (quality <= 0) {
      // Quality reduction reached the minimum; break the loop
      break;
    }
  }
  return compressedImageBytes;

  // final bytes = await file.readAsBytes();
  // int imageLength = bytes.length;
  // if (imageLength < 1000000) return bytes;
  // final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
  // int compressQuality = 100;
  // int length = imageLength;
  // List<int> newByte = [];

  // do {
  //   compressQuality -= 10;
  //   newByte = img.encodeJpg(image, quality: compressQuality);
  //   length = newByte.length;
  // } while (length > 1000000);
  // return newByte;
}
