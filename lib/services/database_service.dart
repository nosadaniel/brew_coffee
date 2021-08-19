import 'package:brew_coffee/constants/firebase.dart';
import 'package:brew_coffee/models/brew_coffe_model.dart';
import 'package:brew_coffee/models/userData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  CollectionReference brewCollections = firebaseFirestore.collection("brews");

  Future<BrewCoffeeModel> addUser(UserDataModel user) async {
    brewCollections.doc(user.uid).set(
        {"name": user.name, "sugars": user.sugars, "strength": user.strength});
    return BrewCoffeeModel(
        name: user.name, sugars: user.sugars, strength: user.strength);
  }

  //update userdata
  Future<void> updateUser(UserDataModel userData) async {
    return await brewCollections.doc(userData.uid).update(userData.toJson());
  }

  deleteItem(String uid) {
    brewCollections.doc(uid).delete();
  }

  //streams List of brews
  Stream<List<BrewCoffeeModel>> brewsDataList() {
    return brewCollections.snapshots().map((QuerySnapshot querySnapshot) {
      List<BrewCoffeeModel> brew = [];
      querySnapshot.docs.forEach((element) {
        brew.add(BrewCoffeeModel.fromSnapshot(element));
      });
      return brew;
    });
  }

  //streams List of specific user
  Future<UserDataModel> userData(String uid) async {
    DocumentSnapshot _doc = await brewCollections.doc(uid).get();
    return UserDataModel.fromSnapshot(_doc, uid);
  }
}
