import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as FirebaseStorage;

class CloudStorageService {
  final FirebaseStorage.Reference _reference =
      FirebaseStorage.FirebaseStorage.instance.ref();

  /// Uploads the file to Firebase storage and return the [downloadUrl]
  Future<String> uploadFile(File file, {String userId = 'guest'}) async {
    var firebaseRef =
        _reference.child('images').child(userId); // create ref for the file

    var timekey = DateTime.now();
    var uploadTask =
        firebaseRef.child(timekey.toString() + ".jpg").putFile(file);
    var imageurl = await (await uploadTask).ref.getDownloadURL();

    return imageurl;
  }
}
