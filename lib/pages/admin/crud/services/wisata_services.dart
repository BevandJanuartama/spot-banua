import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/wisata_model.dart';

class WisataService {
  final CollectionReference wisataRef =
      FirebaseFirestore.instance.collection('wisatas');

  Future<void> createWisata(WisataModel wisata) async {
    await wisataRef.add(wisata.toMap());
  }

  Future<void> updateWisata(String id, WisataModel wisata) async {
    await wisataRef.doc(id).update(wisata.toMap());
  }

  Future<void> deleteWisata(String id) async {
    await wisataRef.doc(id).delete();
  }

  Stream<List<WisataModel>> getAllWisatas() {
    return wisataRef
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => WisataModel.fromDocument(doc))
            .toList());
  }

  Stream<List<WisataModel>> getTopRekomendasi() {
    return wisataRef
        .where('is_top_recomend', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => WisataModel.fromDocument(doc))
            .toList());
  }
}
