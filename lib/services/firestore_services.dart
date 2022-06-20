import 'package:auth_flow/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  addUserInfo(
      {required String uid,
      required String imageUrl,
      required String email,
      required name,
      required int phoneNo}) async {
    var userInfo = FirebaseFirestore.instance.collection('userinfo').doc(email);

    final userData = UserData(
        name: name,
        uid: uid,
        email: email,
        imageUrl: imageUrl,
        phoneNo: phoneNo);

    await userInfo.set(userData.toMap());
  }

  Future<UserData?> getUserInfo({required String email}) async {
    CollectionReference userInfo =
        FirebaseFirestore.instance.collection('userinfo');

    var snapshot = await userInfo.doc(email).get();

    return UserData.fromJson(snapshot.data() as Map<String, dynamic>);
  }
}
