import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  DataService({this.uid});
  final String? uid;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(Map<String, dynamic> model) async {
    return await userCollection.doc(uid).set(model);
  }
}
