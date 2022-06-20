class UserData {
  final String uid;
  final String email;
  final String imageUrl;
  final int phoneNo;

  UserData(
    this.imageUrl,
    this.phoneNo, {
    required this.uid,
    required this.email,
  });
}
