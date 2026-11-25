import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'crud/list_wisata.dart'; // Ganti dengan path yang sesuai


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Column(
        children: [
          // Header ungu dengan foto & nama
          Container(
            padding: const EdgeInsets.only(top: 60, bottom: 20),
            width: double.infinity,
            color: const Color(0xFF31006F),
            child: Column(
              children: [
                // Foto profil bundar
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: const ClipOval(
                    child: Image(
                      image: AssetImage('../assets/images/icon/akso.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Nama
                Text(
                  'Gatti Arya Permana',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Lokasi
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Karang Anyar 3, Banjarbaru',
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Menu utama
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Kartu menu
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        iconColor: const Color(0xFF31006F),
                        icon: LucideIcons.pencil,
                        text: 'Edit Profile',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        iconColor: const Color(0xFF31006F),
                        icon: LucideIcons.shieldCheck,
                        text: 'Keamanan',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        iconColor: const Color(0xFF31006F),
                        icon: LucideIcons.history,
                        text: 'Riwayat',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: LucideIcons.settings,
                        iconColor: const Color(0xFF31006F),
                        text: 'Pengaturan',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: LucideIcons.logOut,
                        text: 'Log Out',
                        textColor: Colors.red,
                        iconColor: Colors.red,
                        showArrow: false, // arrow disembunyikan
                        onTap: () {},
                        textStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Tambah Wisata
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Icon(
                      LucideIcons.plusCircle,
                      color: const Color(0xFF31006F),
                    ),
                    title: Text(
                      'Tambah Wisata',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) =>
                                  const ListWisataScreen(), // Sesuaikan dengan nama class
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
    Color textColor = Colors.black,
    TextStyle? textStyle,
    bool showArrow = true, // parameter baru
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        text,
        style:
            textStyle ??
            GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
      ),
      trailing:
          showArrow
              ? const Icon(Icons.arrow_forward_ios_rounded, size: 16)
              : null, // jika showArrow = false, trailing tidak ditampilkan
      onTap: onTap,
    );
  }
}
