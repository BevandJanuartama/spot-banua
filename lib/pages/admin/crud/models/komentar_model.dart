import 'package:cloud_firestore/cloud_firestore.dart';

class KomentarModel {
  String id;
  String userId;
  String komentar;
  double rating;
  String? fotoUrl;
  String? videoUrl;
  DateTime createdAt;

  KomentarModel({
    required this.id,
    required this.userId,
    required this.komentar,
    required this.rating,
    this.fotoUrl,
    this.videoUrl,
    required this.createdAt,
  });

  factory KomentarModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return KomentarModel(
      id: doc.id,
      userId: data['user_id'],
      komentar: data['komentar'],
      rating: data['rating'].toDouble(),
      fotoUrl: data['foto_url'],
      videoUrl: data['video_url'],
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'komentar': komentar,
      'rating': rating,
      'foto_url': fotoUrl,
      'video_url': videoUrl,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}
