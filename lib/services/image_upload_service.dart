import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

class ImageUploadService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Logger _logger = Logger();

  Future<String?> uploadImageToStorage(Uint8List imageBytes) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return null;
      }

      String storagePath =
          '${user.email}/${DateTime.now().millisecondsSinceEpoch}.png';

      UploadTask uploadTask = _storage.ref(storagePath).putData(imageBytes);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      _logger.i("Download URL: $downloadUrl");

      return downloadUrl;
    } catch (error) {
      _logger.e("Error uploading image: $error");
      return null;
    }
  }
}
