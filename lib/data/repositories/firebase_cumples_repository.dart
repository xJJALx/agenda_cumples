import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:agenda_cumples/data/models/models.dart';

class FirebaseCumplesRepository {
  // ToDo hacer stream
  //  Stream collectionStream = FirebaseFirestore.instance.collection('cumples').snapshots();

  final cumplesRef = FirebaseFirestore.instance.collection('cumples').withConverter<Cumple>(
        fromFirestore: (snapshot, _) => Cumple.fromJson(snapshot.data()!),
        toFirestore: (cumple, _) => cumple.toJson(),
      );

  static Future initializeApp() async {
    await Firebase.initializeApp(
      // Replace with actual values
      options: const FirebaseOptions(
        apiKey: "XXX",
        appId: "XXX",
        messagingSenderId: "XXX",
        projectId: "xagenda-cumplesx",
      ),
    );
  }

  Future<List<Cumple>> getCumplesFirebase() async {
    List<Cumple> cumples = [];

    List<QueryDocumentSnapshot<Cumple>> cumplesResp = await cumplesRef.get().then((snapshot) => snapshot.docs);

    if (cumplesResp.isNotEmpty) {
      for (var cumple in cumplesResp) {
        var newCumple = Cumple(id: cumple.id, name: cumple.data().name, date: cumple.data().date);
        cumples.add(newCumple);
      }
    }

    return cumples;
  }

  // Todo: Hacer respuesta
  Future<void> addCumpleFirebase(Cumple newCumple) async {
    cumplesRef.add(newCumple);
  }

  Future<void> updateCumpleFirebase(Cumple cumple) async {
    Map<String, dynamic> newCumple = {'nombre': cumple.name, 'cumple': cumple.date};
    FirebaseFirestore.instance.collection('cumples').doc(cumple.id).update(newCumple);
  }
}
