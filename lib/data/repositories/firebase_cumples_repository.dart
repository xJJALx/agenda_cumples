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
        var newCumple = Cumple(name: cumple.data().name, date: cumple.data().date);
        cumples.add(newCumple);
      }
    }

    return cumples;
  }

  // Todo: Hacer respuesta
  Future<void> addCumpleFirebase(Cumple cumple) async {
    Cumple newCumple = Cumple(name: cumple.name, date: cumple.date);
    cumplesRef.add(newCumple);
  }
}
