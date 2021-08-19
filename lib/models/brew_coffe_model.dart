import 'package:cloud_firestore/cloud_firestore.dart';

class BrewCoffeeModel {
  final String? sugars;
  final int? strength;
  final String? name;

  BrewCoffeeModel({this.strength, this.name, this.sugars});

  factory BrewCoffeeModel.fromSnapshot(DocumentSnapshot snapshot) {
    return BrewCoffeeModel(
        strength: snapshot['strength'],
        sugars: snapshot['sugars'],
        name: snapshot['name']);
  }
}
