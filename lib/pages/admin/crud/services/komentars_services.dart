import 'package:cloud_firestore/cloud_firestore.dart';

class KomentarService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addKomentar(String wisataId, Map<String, dynamic> data) async {
    await _db.collection('wisatas').doc(wisataId).collection('komentars').add({
      ...data,
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateKomentar(String wisataId, String komentarId, Map<String, dynamic> data) async {
    await _db.collection('wisatas').doc(wisataId).collection('komentars').doc(komentarId).update(data);
  }

  Future<void> deleteKomentar(String wisataId, String komentarId) async {
    await _db.collection('wisatas').doc(wisataId).collection('komentars').doc(komentarId).delete();
  }

  Stream<QuerySnapshot> getKomentars(String wisataId) {
    return _db
        .collection('wisatas')
        .doc(wisataId)
        .collection('komentars')
        .orderBy('created_at', descending: true)
        .snapshots();
  }
}
