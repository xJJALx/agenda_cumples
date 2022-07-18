import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:agenda_cumples/data/models/models.dart';

import '../../firebase_options.dart';

class FirebaseCumplesRepository {
  // ToDo hacer stream
  //  Stream collectionStream = FirebaseFirestore.instance.collection('cumples').snapshots();

  final userRef = FirebaseFirestore.instance.collection('users').withConverter<Cumple>(
        fromFirestore: (snapshot, _) => Cumple.fromJson(snapshot.data()!),
        toFirestore: (cumple, _) => cumple.toJson(),
      );

  static Future initializeApp() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  Future<List<Cumple>> getCumplesFirebase(String userId) async {
    List<Cumple> cumples = [];
    List<QueryDocumentSnapshot<Cumple>> cumplesResp = await userRef
        .doc(userId)
        .collection('cumples')
        .withConverter<Cumple>(
          fromFirestore: (snapshot, _) => Cumple.fromJson(snapshot.data()!),
          toFirestore: (cumple, _) => cumple.toJson(),
        )
        .get()
        .then((snapshot) => snapshot.docs);

    // Sin subCollection
    // List<QueryDocumentSnapshot<Cumple>> cumplesResp = await cumplesRef.doc(userId).collection('cumples').get().then((snapshot) => snapshot.docs);

    if (cumplesResp.isNotEmpty) {
      for (var cumple in cumplesResp) {
        var newCumple = Cumple(id: cumple.id, name: cumple.data().name, date: cumple.data().date);
        cumples.add(newCumple);
      }
    }

    return cumples;
  }

  Future<String> addCumpleFirebase(Cumple newCumple, String userId) async {
    final resp = await userRef.doc(userId).collection('cumples').add(newCumple.toJson());

    return resp.id;
  }

  Future<bool> updateCumpleFirebase(Cumple cumple, String userId) async {
    bool resp = false;
    Map<String, dynamic> newCumple = {'nombre': cumple.name, 'cumple': cumple.date};

    await userRef
          .doc(userId)
          .collection('cumples')
          .doc(cumple.id)
          .update(newCumple)
          .then((value) => resp = true)
          .catchError((error) => resp = false);

    return resp;
  }


  Future<User> getInfoUser(String userId) async {
    debugPrint('FIREBASE 1 $userId');
    User userInfo = User(displayName: '');

    List<QueryDocumentSnapshot<User>> infoUserResp = await userRef
        .doc(userId)
        .collection('info')
        .withConverter<User>(fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!), toFirestore: (infoUser, _) => infoUser.toJson())
        .get()
        .then((snapshot) => snapshot.docs);

    if (infoUserResp.isNotEmpty) {
      for (var info in infoUserResp) {
        userInfo.displayName = info.data().displayName;
        userInfo.ocupacion = info.data().ocupacion;
        userInfo.uid = info.data().uid;
        userInfo.docId = info.id;
      }
    }

    return userInfo;
  }

  Future<String> addInfoUserFirebase(User user) async {
    final resp = await userRef.doc(user.uid).collection('info').add(user.toJson());

    return resp.id;
  }

  Future<bool> updateInfoUserFirebase(User user) async {
    bool resp = false;
    Map<String, dynamic> newUser = {'displayName': user.displayName, 'ocupacion': user.ocupacion, "uid": user.uid};

    await userRef
          .doc(user.uid)
          .collection('info')
          .doc(user.docId)
          .update(newUser)
          .then((value) => resp = true)
          .catchError((error) => resp = false);

    return resp;
  }
}
