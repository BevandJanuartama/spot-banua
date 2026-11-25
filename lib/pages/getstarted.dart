import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'login.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage>
    with SingleTickerProviderStateMixin {
  final PageController _controller = PageController();
  int _currentPage = 0;

  late AnimationController _btnController;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "../assets/images/vector/onboard1.png",
      "title": "Menemukan Wisata Terdekat",
      "desc":
          "Anda dapat menemukan wisata terdekat disekitar lokasi di sekitar Kalimantan Selatan dengan detail yang lengkap",
      "background": "../assets/images/vector/back1.png",
    },
    {
      "image": "../assets/images/vector/onboard2.png",
      "title": "Baca atau Berikan Rating/Ulasan",
      "desc":
          "Anda dapat membaca ulasan dan rating dari orang lain dan memberi ulasan terkait wisata yang pernah Anda kunjungi",
      "background": "../assets/images/vector/back2.png",
    },
    {
      "image": "../assets/images/vector/onboard3.png",
      "title": "Simpan Wisata Favorit Mu",
      "desc":
          "Simpan wisata favorit Anda dan akses kembali dengan mudah tanpa harus mencarinya ulang",
      "background": "../assets/images/vector/back3.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _btnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _btnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == onboardingData.length - 1;

    if (isLastPage) {
      _btnController.forward();
    } else {
      _btnController.reset();
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              onboardingData[_currentPage]["background"]!,
              fit: BoxFit.cover,
            ),
          ),

          // PageView with smoother physics
          PageView.builder(
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(data['image']!, height: 350),
                    const SizedBox(height: 30),
                    Text(
                      data['title']!,
                      style: GoogleFonts.poppins(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      data['desc']!,
                      style: GoogleFonts.raleway(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),

          // Smooth Indicator
          Positioned(
            bottom: 110,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: onboardingData.length,
                effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Colors.white,
                  dotColor: Colors.white60,
                ),
              ),
            ),
          ),

          // Button muncul dari bawah
          Positioned(
            bottom: 36,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _btnController,
              builder: (context, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: const Offset(0, 0),
                  ).animate(
                    CurvedAnimation(
                      parent: _btnController,
                      curve: Curves.easeOutBack,
                    ),
                  ),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isLastPage ? 1.0 : 0.0,
                    child: child,
                  ),
                );
              },
              child: Center(
                child: SizedBox(
                  height: 45,
                  width: 290,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 500),
                          child: const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Mulai",
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF31006F),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
