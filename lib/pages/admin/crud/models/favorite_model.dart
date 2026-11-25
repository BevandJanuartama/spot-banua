import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteModel {
  String wisataId;
  DateTime favoritedAt;

  FavoriteModel({
    required this.wisataId,
    required this.favoritedAt,
  });

  factory FavoriteModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteModel(
      wisataId: doc.id,
      favoritedAt: (data['favorited_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'favorited_at': Timestamp.fromDate(favoritedAt),
    };
  }
}
