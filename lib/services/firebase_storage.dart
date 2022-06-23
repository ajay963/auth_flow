import 'dart:io';
import 'package:auth_flow/theme.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebastorage;
import 'package:flutter/material.dart';

class StorageService {
  final firebastorage.FirebaseStorage storage =
      firebastorage.FirebaseStorage.instance;

  Future<dynamic> uploadFile(
      {required String filePath,
      required String fileName,
      required BuildContext context}) async {
    File file = File(filePath);
    firebastorage.TaskSnapshot uploadTask;
    uploadTask = await storage.ref('userPic/$fileName').putFile(file);
    LinearProgressIndicator(
      value: uploadTask.bytesTransferred / uploadTask.totalBytes,
      backgroundColor: kshade1,
      color: kshade2,
    );

    return uploadTask.ref.getDownloadURL();
  }
}
