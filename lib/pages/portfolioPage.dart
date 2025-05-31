import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNavbar(),
            _buildHeroSection(context),
            const SizedBox(height: 60),
            _buildFeatureSection(
              context,
              title: 'Yeni Özellik: Deneme Sınavları',
              description:
                  'Çöz, gör, geliş! Sıralamanı diğer kullanıcılarla kıyasla ve eksiklerini fark et.',
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/3198/3198501.png',
            ),
            _buildFeatureSection(
              context,
              title: 'Notlarım Özelliği',
              description: 'Kendi notlarını oluştur, düzenle ve sil!',
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/1828/1828911.png',
              reverse: true,
            ),
            _buildFeatureSection(
              context,
              title: 'İpucu Sayfası',
              description:
                  'Zaman yönetimi, strateji ve sınav tüyoları artık bir arada.',
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/2529/2529521.png',
            ),
            _buildGallerySection(),
            const SizedBox(height: 80),
            Text(
              '© 2025 KamuCEP | Tüm Hakları Saklıdır.',
              style: GoogleFonts.poppins(color: Colors.white54, fontSize: 12),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNavbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.school, color: Colors.white),
          Row(
            children:
                ['Home', 'About', 'Features', 'Screenshots', 'Contact']
                    .map(
                      (label) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          label,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFEB4C89), Color(0xFF6753E2)],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'Whatsapp',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FadeInLeft(
              duration: const Duration(milliseconds: 800),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KamuCEP Platformu',
                    style: GoogleFonts.outfit(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ShaderMask(
                    shaderCallback:
                        (bounds) => const LinearGradient(
                          colors: [Color(0xFFFF6FD8), Color(0xFF3813C2)],
                        ).createShader(bounds),
                    child: Text(
                      'Sınavlara Hazırlıkta Yeni Dönem',
                      style: GoogleFonts.outfit(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Performansını analiz et, eksiklerini gör, sıralamanı takip et.\nKamuCEP ile sınav hazırlığında her adımı profesyonelleştir.',
                    style: GoogleFonts.outfit(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEB4C89),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Hemen Keşfet"),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 40),
          ZoomIn(
            duration: const Duration(milliseconds: 900),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.network(
                'https://hamad-anwar.github.io/Portfolio/assets/images/robot.png',
                height: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureSection(
    BuildContext context, {
    required String title,
    required String description,
    required String imageUrl,
    bool reverse = false,
  }) {
    final content = [
      _featureText(title, description),
      const SizedBox(width: 40),
      _featureImage(imageUrl),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: FadeInUp(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: reverse ? content.reversed.toList() : content,
        ),
      ),
    );
  }

  Widget _featureText(String title, String description) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: GoogleFonts.outfit(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _featureImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(url, width: 300, height: 250, fit: BoxFit.cover),
    );
  }

  Widget _buildGallerySection() {
    final List<Map<String, String>> screenshots = [
      {
        "image": "https://cdn-icons-png.flaticon.com/512/1828/1828911.png",
        "title": "Notlarım Sayfası",
        "desc":
            "Kullanıcıların kişisel notlar tutabileceği özelleştirilmiş ekran.",
      },
      {
        "image": "https://cdn-icons-png.flaticon.com/512/3198/3198501.png",
        "title": "Deneme Sınavları",
        "desc":
            "Gerçek zamanlı sıralama ve gelişim takibi ile test çözme modülü.",
      },
      {
        "image": "https://cdn-icons-png.flaticon.com/512/2529/2529521.png",
        "title": "İpucu Ekranı",
        "desc":
            "Zaman yönetimi ve sınav teknikleri ile başarıya bir adım daha yakınsınız.",
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Uygulama Özellikleri",
            style: GoogleFonts.outfit(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          Column(
            children: List.generate(screenshots.length, (index) {
              final item = screenshots[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SlideInUp(
                  duration: Duration(milliseconds: 700 + index * 200),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          item["image"]!,
                          width: 160,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"]!,
                              style: GoogleFonts.outfit(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item["desc"]!,
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
