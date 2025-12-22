import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/feature/auth/data/model/user_model.dart';

class AuthFirebase {
  static CollectionReference<UserModel> getCollectionUser() {
    return FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        );
  }

  static Future<void> addUser({
    required String email,
    required String password,
    required String userName,
  }) async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    await getCollectionUser().doc(id).set(UserModel(
        id: id, email: email, password: password, userName: userName));
  }
}
