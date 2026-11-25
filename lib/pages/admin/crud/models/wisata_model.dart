import 'package:cloud_firestore/cloud_firestore.dart';

class WisataModel {
  String id;
  String nama;
  String wilayah;
  String mapsUrl;
  bool isTopRecomend;
  String gambarUrl;
  DateTime createdAt;

  WisataModel({
    required this.id,
    required this.nama,
    required this.wilayah,
    required this.mapsUrl,
    required this.isTopRecomend,
    required this.gambarUrl,
    required this.createdAt,
  });

  factory WisataModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return WisataModel(
      id: doc.id,
      nama: data['nama'],
      wilayah: data['wilayah'],
      mapsUrl: data['maps_url'],
      isTopRecomend: data['is_top_recomend'],
      gambarUrl: data['gambar_url'],
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'wilayah': wilayah,
      'maps_url': mapsUrl,
      'is_top_recomend': isTopRecomend,
      'gambar_url': gambarUrl,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}
