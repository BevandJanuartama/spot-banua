import 'package:flutter/material.dart';
import 'getstarted.dart'; // sesuaikan path jika perlu

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fallController;
  late AnimationController _moveAndFadeController;

  late Animation<double> _fallAnimation;
  late Animation<double> _fadeTextAnimation;
  late Animation<double> _moveLeftAnimation;
  late Animation<Color?> _backgroundColorAnimation;

  @override
  void initState() {
    super.initState();

    _fallController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _moveAndFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeTextAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _moveAndFadeController, curve: Curves.easeIn),
    );

    _moveLeftAnimation = Tween<double>(begin: 0, end: -120).animate(
      CurvedAnimation(parent: _moveAndFadeController, curve: Curves.easeInOut),
    );

    _backgroundColorAnimation = ColorTween(
      begin: Colors.black,
      end: Colors.white,
    ).animate(_moveAndFadeController);

    _fallController.forward();

    _fallController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 300), () {
          _moveAndFadeController.forward().then((_) async {
            // Tambahkan delay tambahan untuk total ~5 detik
            await Future.delayed(const Duration(seconds: 2));

            // Navigasi dengan transisi fade yang lebih smooth
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 800),
                pageBuilder: (_, __, ___) => const GetStartedPage(),
                transitionsBuilder: (_, animation, __, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _fallController.dispose();
    _moveAndFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    _fallAnimation = Tween<double>(begin: -screenHeight * 0.4, end: 0).animate(
      CurvedAnimation(parent: _fallController, curve: Curves.easeOutBack),
    );

    return AnimatedBuilder(
      animation: Listenable.merge([_fallController, _moveAndFadeController]),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _backgroundColorAnimation.value ?? Colors.black,
          body: SafeArea(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(
                      _moveLeftAnimation.value,
                      _fallAnimation.value,
                    ),
                    child: Image.asset(
                      'assets/images/icon/spotbanua.png',
                      width: 62,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                      _moveLeftAnimation.value + 160,
                      _fallAnimation.value,
                    ),
                    child: Opacity(
                      opacity: _fadeTextAnimation.value,
                      child: const Text(
                        'SpotBanua',
                        style: TextStyle(
                          color: Color(0xFF3F8DC7),
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
