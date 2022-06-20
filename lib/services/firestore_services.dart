import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  addUserInfo(
      {required String email, required name, required String phoneNo}) async {
    CollectionReference feedsCollection = FirebaseFirestore.instance
        .collection('userinfo')
        .doc()
        .collection(email);
    Map<String, dynamic> userData = {
      "userName": name,
      "userEmail": email,
      "phoneNo": phoneNo,
    };

    await feedsCollection.add(userData);
  }
}
