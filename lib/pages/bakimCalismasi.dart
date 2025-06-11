// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class BakimPage extends StatelessWidget {
  const BakimPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1B),
      body: Stack(
        children: [
          // ✅ Logo yukarıda ve ortalı
          // LOGO sol üst köşede
          Positioned(
            top: 40,
            left: 20,
            child: ZoomIn(
              duration: const Duration(milliseconds: 600),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white24,
                          blurRadius: 30,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'KamuCEP',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ZoomIn(
                      duration: const Duration(milliseconds: 800),
                      child: Icon(
                        Icons.construction,
                        color: Colors.amberAccent,
                        size: size.width < 600 ? 80 : 100,
                      ),
                    ),
                    const SizedBox(height: 30),
                    FadeInDown(
                      child: Text(
                        "Kısa Bir Ara...",
                        style: GoogleFonts.outfit(
                          fontSize: size.width < 600 ? 28 : 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInDown(
                      delay: const Duration(milliseconds: 300),
                      child: Text(
                        "Şu anda sistemimizi sizin için geliştiriyoruz.\nEn kısa sürede tekrar hizmetinizde olacağız.",
                        style: GoogleFonts.outfit(
                          fontSize: size.width < 600 ? 16 : 18,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),

          // ✅ En alt telif hakkı yazısı
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '© 2025 KamuCEP | Tüm Hakları Saklıdır.',
                style: GoogleFonts.poppins(color: Colors.white54, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
