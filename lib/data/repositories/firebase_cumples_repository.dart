import 'package:agenda_cumples/data/models/cumple_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:agenda_cumples/data/models/models.dart';

class FirebaseCumplesRepository {
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
    // CollectionReference collectionReference = FirebaseFirestore.instance.collection('cumples');
    // QuerySnapshot cumples = await collectionReference.get();

    List<Cumple> cumples = [];

    final cumplesRef = FirebaseFirestore.instance.collection('cumples').withConverter<CumpleResponse>(
          fromFirestore: (snapshot, _) => CumpleResponse.fromJson(snapshot.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );

    List<QueryDocumentSnapshot<CumpleResponse>> cumplesResp = await cumplesRef.get().then((snapshot) => snapshot.docs);

    if (cumplesResp.isNotEmpty) {
      for (var cumple in cumplesResp) {
        var newCumple = Cumple(name: cumple.data().nombre, date: cumple.data().cumple);
        cumples.add(newCumple);
      }
    }

    return cumples;
  }
}
