import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class PickImageHelper {
  static final PickImageHelper _singleton = PickImageHelper._internal();

  factory PickImageHelper() {
    return _singleton;
  }

  PickImageHelper._internal();

  final _picker = ImagePicker();

  final List<String> _latestPath = [];

  Future<XFile?> pickImage({bool? removeLatestImage}) async {
    if (removeLatestImage ?? false) removeAll();

    final result = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );

    if (result != null) _latestPath.add(result.path);

    return result;
  }

  void removeImageFiles({required String path}) {
    if (path.isEmpty) return;
    try {
      File(path).delete();
    } on Exception catch (_) {}
  }

  void removeAll() {
    for (var e in _latestPath) {
      removeImageFiles(path: e);
    }
    _latestPath.clear();
  }
  Future<Uint8List?> pickImageBytes() async {
    final result = await pickImage();

    return result?.readAsBytes();
  }

// // Pick an image
// final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
// // Capture a photo
// final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
// // Pick a video
// final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
// // Capture a video
// final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
// // Pick multiple images
// final List<XFile>? images = await _picker.pickMultiImage();
}
