import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/feature/auth/data/model/user_model.dart';
import 'package:tasky/feature/home/data/model/task_model.dart';

abstract class FirebaseUserDatabase {
  static CollectionReference<UserModel> collectionUser() {
    return FirebaseFirestore.instance
        .collection("User")
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  static Future<void> createUser(UserModel user) async {
    return collectionUser().doc(user.id).set(user);
  }

  static Future<UserModel?> getUser(String userId) async {
    var data = await collectionUser().doc(userId).get();
    return data.data();
  }

  static CollectionReference<TaskModel> collectionTasks() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    return collectionUser()
        .doc(user.uid)
        .collection("Tasks")
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  static Future<void> addTask({
    required String title,
    required String description,
    required int priority,
    required DateTime date,
  }) async {
    final docRef = collectionTasks().doc();
    final taskId = docRef.id;

    final userTask = TaskModel(
      id: taskId,
      title: title,
      description: description,
      priority: priority,
      date: date,
      isCompleted: false,
    );

    await docRef.set(userTask);
  }

  static Future<List<TaskModel>> getAllTasks() async {
    final snapshot = await collectionTasks().get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> deleteTask(TaskModel task) async {
    return collectionTasks().doc(task.id).delete();
  }

  static Future<void> updateTask(TaskModel task) async {
    await collectionTasks().doc(task.id).update(task.toJson());
  }

  static Future<void> toggleTaskCompletion(TaskModel task) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    return updateTask(updatedTask);
  }
}
