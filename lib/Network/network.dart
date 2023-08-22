import 'package:cloud_firestore/cloud_firestore.dart';

class Network {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<dynamic> get(String collection, String id) async {
    return await firestore.collection(collection).doc(id).get();
  }

  Future<void> add(String collection, Map<String, dynamic> data) async {
    await firestore.collection(collection).add(data);
  }
}
