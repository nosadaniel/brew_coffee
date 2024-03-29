import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataModel {
  String? uid, name, sugars;
  int strength;
  UserDataModel({this.uid, this.name, required this.strength, this.sugars});

  factory UserDataModel.fromSnapshot(DocumentSnapshot snapshot, String uid) {
    return UserDataModel(
        uid: uid,
        strength: snapshot['strength'],
        sugars: snapshot['sugars'],
        name: snapshot['name']);
  }

  Map<String, dynamic> toJson() {
    return {"strength": strength, "sugars": sugars, "name": name};
  }
}
