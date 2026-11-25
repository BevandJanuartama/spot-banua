import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signin.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -1.0), // bergerak ke atas
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

Future<void> _navigateToPage(Widget page) async {
  await _controller.forward(); // mulai animasi langsung
  await Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 330),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child; // biar Hero bisa animasi normal
      },
    ),
  );
  _controller.reverse(); // setelah kembali, animasi balik
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // Background image (tetap diam)
        Hero(
          tag: 'bg_pasar',
          child: Image.asset(
            '../assets/images/effect/background.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.topCenter,
          ),
        ),

        // Gelombang bawah tetap sebagai Hero utama
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Hero(
            tag: 'gelombang_bawah',
            child: Image.asset(
              'assets/images/vector/Vector5.png',
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Gelombang atas tetap boleh ikut bergerak (tidak Hero)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SlideTransition(
            position: _slideAnimation,
            child: Image.asset(
              'assets/images/vector/Vector6.png',
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Konten utama yang bergerak
        SlideTransition(
          position: _slideAnimation,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Mulai Perjalanan\nAnda',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 180),
                      child: Column(
                        children: [
                          // Tombol Sign In
                          SizedBox(
                            width: 232,
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF31006F),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => _navigateToPage(const SignInScreen()),
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.raleway(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Tombol Sign Up
                          SizedBox(
                            width: 232,
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => _navigateToPage(const SignUpScreen()),
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF31006F),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

  }

