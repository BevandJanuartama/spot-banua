import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/wisata_model.dart'; // Lokasi file WisataModel

class AddEditWisataScreen extends StatefulWidget {
  final WisataModel? wisata;

  const AddEditWisataScreen({Key? key, this.wisata}) : super(key: key);

  @override
  State<AddEditWisataScreen> createState() => _AddEditWisataScreenState();
}

class _AddEditWisataScreenState extends State<AddEditWisataScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _nama;
  late String _wilayah;
  late String _mapsUrl;
  late bool _isTopRecomend;
  late String _gambarUrl;

  @override
  void initState() {
    super.initState();
    if (widget.wisata != null) {
      _nama = widget.wisata!.nama;
      _wilayah = widget.wisata!.wilayah;
      _mapsUrl = widget.wisata!.mapsUrl;
      _isTopRecomend = widget.wisata!.isTopRecomend;
      _gambarUrl = widget.wisata!.gambarUrl;
    } else {
      _nama = '';
      _wilayah = '';
      _mapsUrl = '';
      _isTopRecomend = false;
      _gambarUrl = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF31006F),
        title: Text(
          widget.wisata != null ? 'Edit Wisata' : 'Tambah Wisata',
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Nama
              _buildTextField(
                label: 'Nama Wisata',
                initialValue: _nama,
                onSaved: (val) => _nama = val!,
              ),

              // Wilayah
              _buildTextField(
                label: 'Wilayah',
                initialValue: _wilayah,
                onSaved: (val) => _wilayah = val!,
              ),

              // Google Maps URL
              _buildTextField(
                label: 'Google Maps URL',
                initialValue: _mapsUrl,
                onSaved: (val) => _mapsUrl = val!,
              ),

              // Gambar URL
              _buildTextField(
                label: 'Gambar URL',
                initialValue: _gambarUrl,
                onSaved: (val) => _gambarUrl = val!,
              ),

              // Checkbox
              SwitchListTile(
                title: const Text('Top Recommended'),
                value: _isTopRecomend,
                onChanged: (val) => setState(() => _isTopRecomend = val),
                activeColor: const Color(0xFF31006F),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF31006F),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: _saveWisata,
                child: Text(
                  widget.wisata != null ? 'Update' : 'Simpan',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String? initialValue,
    required FormFieldSetter<String> onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: const Color(0xFFD9D9D9),
        ),
        validator: (val) =>
            val == null || val.isEmpty ? 'Harus diisi' : null,
        onSaved: onSaved,
      ),
    );
  }

  void _saveWisata() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final wisataCollection =
          FirebaseFirestore.instance.collection('wisata');

      if (widget.wisata != null) {
        // Update
        await wisataCollection.doc(widget.wisata!.id).update({
          'nama': _nama,
          'wilayah': _wilayah,
          'maps_url': _mapsUrl,
          'is_top_recomend': _isTopRecomend,
          'gambar_url': _gambarUrl,
          'created_at': Timestamp.now(),
        });
      } else {
        // Create
        await wisataCollection.add({
          'nama': _nama,
          'wilayah': _wilayah,
          'maps_url': _mapsUrl,
          'is_top_recomend': _isTopRecomend,
          'gambar_url': _gambarUrl,
          'created_at': Timestamp.now(),
        });
      }

      Navigator.pop(context);
    }
  }
}
