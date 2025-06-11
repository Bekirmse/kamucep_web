// ignore_for_file: file_names, deprecated_member_use

import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';

class ModernPortfolio extends StatefulWidget {
  const ModernPortfolio({super.key});

  @override
  State<ModernPortfolio> createState() => _ModernPortfolioState();
}

class _ModernPortfolioState extends State<ModernPortfolio> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _pricingKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A23),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final bool isMobile = width < 800;
            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _Header(
                    pricingKey: _pricingKey,
                    scrollController: _scrollController,
                  ),
                  _HeroSection(
                    isMobile: isMobile,
                    onDiscoverPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_featuresKey.currentContext != null) {
                          Scrollable.ensureVisible(
                            _featuresKey.currentContext!,
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeInOut,
                          );
                        }
                      });
                    },
                  ),
                  _FeaturesSection(key: _featuresKey, isMobile: isMobile),
                  _PricingSection(key: _pricingKey),
                  TestimonialSection(),

                  _FooterSection(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final GlobalKey pricingKey;
  final ScrollController scrollController;

  const _Header({required this.pricingKey, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 36),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.shade900.withOpacity(0.7),
            Colors.indigo.shade900.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.9),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset('assets/images/kamucepicon.png', width: 56, height: 56),
          const SizedBox(width: 12),
          Text(
            'Kamucep',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          const Spacer(),
          if (MediaQuery.of(context).size.width >= 800)
            Row(
              children: [
                _NavButton(
                  label: 'Ana Sayfa',
                  onPressed: () {
                    scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
                _NavButton(
                  label: 'Fiyatlar',
                  onPressed: () {
                    if (pricingKey.currentContext != null) {
                      Scrollable.ensureVisible(
                        pricingKey.currentContext!,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ],
            )
          else
            Builder(
              builder:
                  (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
            ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _NavButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.white24),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          color: Colors.white.withOpacity(0.85),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onDiscoverPressed;

  const _HeroSection({required this.isMobile, required this.onDiscoverPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 24 : 64,
      ),
      constraints: const BoxConstraints(maxWidth: 1200),
      child:
          isMobile
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _HeroText(
                    centered: true,
                    onDiscoverPressed: onDiscoverPressed,
                  ),
                  const SizedBox(height: 40),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _HeroText(
                      centered: false,
                      onDiscoverPressed: onDiscoverPressed,
                    ),
                  ),
                  const SizedBox(width: 60),
                ],
              ),
    );
  }
}

class _HeroText extends StatelessWidget {
  final bool centered;
  final VoidCallback onDiscoverPressed;

  const _HeroText({required this.centered, required this.onDiscoverPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        FadeInDown(
          duration: const Duration(milliseconds: 700),
          child: Text(
            'Kamucep Platformu',
            textAlign: centered ? TextAlign.center : TextAlign.left,
            style: GoogleFonts.outfit(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              height: 1.1,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 6,
                  color: Colors.deepPurple.shade900,
                  offset: const Offset(3, 4),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        FadeInDown(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 700),
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [Color(0xFFFF6FD8), Color(0xFF3813C2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Text(
              'Sınavlara Hazırlıkta Yeni Dönem',
              textAlign: centered ? TextAlign.center : TextAlign.left,
              style: GoogleFonts.outfit(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        FadeInUp(
          delay: const Duration(milliseconds: 600),
          duration: const Duration(milliseconds: 700),
          child: Text(
            'Sınava hazırlık sürecin artık daha profesyonel. Kamucep ile performansını analiz et, eksik olduğun konuları belirle, güçlü yönlerini geliştir. Sadece soru çözmekle kalma; sonuçlarını incele, sıralamanı takip et, gelişimini zamana yayarak planlı çalış.\n\nHer deneme sınavı sonrasında detaylı analiz al, diğer kullanıcılarla karşılaştırmalı sıralama gör, hangi konularda öne çıktığını ve nerelerde destek alman gerektiğini keşfet.\n\nKamucep, seni başarıya en yakın noktaya taşımak için tasarlandı. Artık çalışmak daha verimli, ilerlemek daha kolay. Sınav maratonunda yalnız değilsin!',
            textAlign: centered ? TextAlign.center : TextAlign.left,
            style: GoogleFonts.outfit(
              fontSize: 17,
              height: 1.6,
              color: Colors.white70,
            ),
          ),
        ),
        const SizedBox(height: 40),
        FadeInUp(
          delay: const Duration(milliseconds: 900),
          duration: const Duration(milliseconds: 700),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEB4C89),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 8,
              shadowColor: Colors.pinkAccent.withOpacity(0.6),
            ),
            onPressed: onDiscoverPressed,
            child: Text(
              'Hemen Keşfet',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  final bool isMobile;
  const _FeaturesSection({super.key, required this.isMobile});

  final List<Map<String, String>> featuresData = const [
    {
      'icon': 'smart_toy',
      'title': 'KamuCEP AI Asistan',
      'desc':
          'KamuCEP’in yapay zekâ destekli asistanı, çözdüğünüz sorulara verdiğiniz yanıtlara göre eksik olduğunuz konuları belirler ve bu doğrultuda seviyenize uygun kişiselleştirilmiş testler oluşturur. Ayrıca, çözemediğiniz ya da yanlış yaptığınız soruları adım adım analiz ederek size doğru çözüm yolunu gösterir. Konu anlatımlarıyla destek sağlar, özet çıkarır ve sizi sadece ezberle değil kavrayarak öğrenmeye yönlendirir.',
    },

    {
      'icon': 'timer',
      'title': 'Deneme Sınavları',
      'desc':
          'Gerçek sınav formatında hazırlanmış deneme sınavlarıyla bilgini test et, zaman yönetimini geliştir. Deneme sonunda, doğru-yanlış analizlerinle birlikte anlık başarı sıralaman hesaplanır ve diğer kullanıcılarla karşılaştırmalı olarak sunulur. Böylece hem seviyeni görür hem de eksik olduğun alanları tespit edebilirsin. Sınavlara daha hazırlıklı ve özgüvenli girmen için ideal bir simülasyon deneyimi sunar.',
    },

    {
      'icon': 'insights',
      'title': 'İstatistik Takibi',
      'desc':
          'KamuCEP, çözmüş olduğun her soruyu, testleri ve deneme sınavlarını detaylı şekilde analiz eder. Başarı oranlarını, konu bazlı performansını ve zaman içindeki gelişimini tek bir ekranda grafiklerle sunar. Bu sistem sayesinde hangi konularda ilerleme kaydettiğini, nerelerde zorlandığını ve genel başarı trendini anlık olarak görebilirsin. Kendi gelişimini izlemek hiç bu kadar kolay olmamıştı.',
    },

    {
      'icon': 'menu_book',
      'title': 'Kapsamlı İçerik',
      'desc':
          'KamuCEP, sınavlara yönelik ihtiyaç duyabileceğin tüm içeriği tek çatı altında sunar. Güncel mevzuatlar, özgün testler, geçmiş yılların soruları ve farklı konu başlıklarına göre sınıflandırılmış yüzlerce soru ile donatılmıştır. İçerikler sürekli güncellenerek yasal değişikliklere uyum sağlar, böylece her zaman en doğru bilgiye ulaşır ve hazırlığını eksiksiz yaparsın.',
    },
    {
      'icon': 'note_alt',
      'title': 'Not Tutma Sistemi',
      'desc':
          'Çalışırken aklına gelen önemli bilgileri, püf noktalarını ya da tekrar etmek istediğin konuları anında uygulama içinden not alabilirsin. Tüm notların kolayca erişebilmen için organize edilir. Bu sayede konular arasında kaybolmaz, kişisel çalışma defterin her zaman elinin altında olur.',
    },
    {
      'icon': 'headset_mic',
      'title': 'Canlı Destek',
      'desc':
          'Uygulama ile ilgili yaşadığın teknik sorunlarda veya içerik hakkında merak ettiklerinde doğrudan destek ekibimize ulaşabilirsin. Haftanın 7 günü aktif olan canlı destek hattı sayesinde soruların hızlıca yanıtlanır, karşılaştığın problemler en kısa sürede çözülür. Eğitim sürecinde yalnız hissetmez, her zaman yanında bir destek bulursun.',
    },
  ];

  IconData toIconData(String name) {
    switch (name) {
      case 'smart_toy':
        return Icons.smart_toy;
      case 'timer':
        return Icons.timer;
      case 'analytics':
        return Icons.analytics;
      case 'insights':
        return Icons.insights;
      case 'menu_book':
        return Icons.menu_book;
      case 'headset_mic':
        return Icons.headset_mic; // Canlı destek ikonu
      case 'support_agent':
        return Icons.support_agent; // Alternatif destek ikonu
      case 'chat_bubble':
        return Icons.chat_bubble; // Sohbet balonu
      case 'question_answer':
        return Icons.question_answer; // Soru-cevap
      case 'contact_support':
        return Icons.contact_support; // Yardım simgesi
      case 'live_help':
        return Icons.live_help; // Yardımcı ikon
      case 'note_alt':
        return Icons.note_alt; // Yardımcı ikon
      default:
        return Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = isMobile ? 1 : 3;
    // EN ÜSTE (utils gibi bir yere) EKLE
    EdgeInsets responsivePadding(bool isMobile) =>
        EdgeInsets.symmetric(horizontal: isMobile ? 24 : 64, vertical: 60);

    return Container(
      padding: responsivePadding(isMobile),

      color: Colors.indigo.shade900.withOpacity(0.12),
      child: Column(
        children: [
          FadeInUp(
            child: Text(
              'Öne Çıkan Özellikler',
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 32,
              mainAxisSpacing: 32,
              childAspectRatio: 1.1,
            ),
            itemCount: featuresData.length,
            itemBuilder: (context, index) {
              final feature = featuresData[index];
              return FadeInUp(
                delay: Duration(milliseconds: 150 * index),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6FD8), Color(0xFF3813C2)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purpleAccent.withOpacity(0.5),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Icon(
                          toIconData(feature['icon']!),
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        feature['title']!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        feature['desc']!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  final List<Map<String, String>> testimonials = [
    {
      "quote": "Eksiklerimi ilk kez bu kadar net gördüm, helal olsun.",
      "author": "Ali M. (Mağusa)",
    },
    {
      "quote":
          "Sınavdan evvel deneme çözdüm, AI bana eksiklerimi bir bir gösterdi. Vallahi helal olsun.",
      "author": "Selin T. (Lefkoşa)",
    },

    {
      "quote": "Benim kız da başladı kullanmaya. Eve Kamu havası geldi vallai.",
      "author": "Huriye A. (Güzelyurt)",
    },
    {
      "quote":
          "Sistemi açınca notlarımı da tutabiliyorum, ha bire deftere yazmaktan kurtuldum,.",
      "author": "İsmail N. (İskele)",
    },
    {
      "quote":
          "Canlı destek gece bile yazınca cevap veriyor, şaşırdım açıkçası. Hizmet süperdir süper!",
      "author": "Derya Ö. (Lefke)",
    },
    {
      "quote":
          "Offline deneme çözmek baya işime yaradı, internet gitse de çalışabiliyorum. Bravo size!",
      "author": "Hasan E. (Mağusa)",
    },
    {
      "quote": "Neyde iyiyim, neyde zayıfım net belli. Stres da kalmadı.",
      "author": "Zehra S. (Lefkoşa)",
    },
    {
      "quote": "İlk kez bir uygulamayla çalışmak bu kadar keyifli oldu.",
      "author": "Rasim K. (Girne)",
    },
    {
      "quote":
          "Hem yasaları öğreniyorum hem de test çözerek pekiştiriyorum. Valla bu uygulama candır.",
      "author": "Aysel Ç. (Güzelyurt)",
    },
  ];

  @override
  void initState() {
    super.initState();
    // Otomatik sayfa geçişi
    Future.delayed(const Duration(seconds: 4), _autoScroll);
  }

  void _autoScroll() {
    if (!mounted) return;
    if (_pageController.hasClients) {
      final nextPage = (_currentPage + 1) % testimonials.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      _currentPage = nextPage;
    }
    Future.delayed(const Duration(seconds: 5), _autoScroll);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      color: Colors.deepPurple.shade900.withOpacity(0.95),
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 16 : 64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Kullanıcılarımız Ne Diyor?',
            style: GoogleFonts.outfit(
              fontSize: isMobile ? 24 : 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: isMobile ? null : 220,
            child:
                isMobile
                    ? Column(
                      children:
                          testimonials
                              .map(
                                (testimonial) => Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.indigo.shade700.withOpacity(0.9),
                                        Colors.purple.shade700.withOpacity(0.7),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black45,
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.format_quote_rounded,
                                        color: Colors.white24,
                                        size: 36,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '"${testimonial['quote']}"',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.outfit(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white70,
                                          height: 1.4,
                                        ),
                                      ),
                                      const SizedBox(height: 14),
                                      Text(
                                        '- ${testimonial['author']}',
                                        style: GoogleFonts.outfit(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                    )
                    : PageView.builder(
                      controller: _pageController,
                      itemCount: testimonials.length,
                      itemBuilder: (context, index) {
                        final testimonial = testimonials[index];
                        return AnimatedOpacity(
                          opacity: _currentPage == index ? 1.0 : 0.5,
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.indigo.shade700.withOpacity(0.9),
                                  Colors.purple.shade700.withOpacity(0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.format_quote_rounded,
                                  color: Colors.white24,
                                  size: 40,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '"${testimonial['quote']}"',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(
                                    fontSize: 17,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white70,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  '- ${testimonial['author']}',
                                  style: GoogleFonts.outfit(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.85),
            Colors.deepPurple.shade900.withOpacity(0.9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24),
      alignment: Alignment.center,
      child: Text(
        '© 2025 Kamucep | Tüm Hakları Saklıdır.',
        style: GoogleFonts.outfit(
          color: Colors.white54,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _PricingSection extends StatelessWidget {
  const _PricingSection({super.key});

  final List<String> features = const [
    "Sınırsız deneme sınavı",
    "KamuCEP AI asistan (soru çözüm ve analiz)",
    "Geçmiş sınav özeti",
    "Not tutma sistemi",
    "Canlı destek",
    "Sonuç analizi",
    "Özel test oluşturma",
    "Soru kaynaklarına tam erişim",
    "Offline test çözme",
    "Güncel soru havuzu",
  ];

  final List<String> laws = const [
    "Bilgisayar",
    "Genel Kültür",
    "Türkçe",
    "KKTC Anayasası",
    "KKTC ve TC Hükümeti Arasında Onay Yasası",
    "Kamu Alacaklarının Tahsili Usulü Yasası",
    "Kamu Görevlileri Yasası",
    "Kamu Sağlık Çalışanları Yasası",
    "Kıbrıs Türk Sigortalar Yasası",
    "Mahkeme Kayıt Kalemleri Tüzüğü",
    "Mahkemeler Yasası",
    "Sivil Havacılık Dairesi Yasası",
    "Sosyal Güvenlik Yasası",
    "Yataklı Tedavi Kurumları Dairesi Yasası",
    "Öğretmenler Yasası",
    "Öğretmenlik Sınavı Ön Hazırlık",
    "İyi İdare Yasası",
  ];

  Widget _buildCard(String store, String logoPath, String url) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(logoPath, height: 40),
            const SizedBox(height: 16),
            Text(
              'Tek Ödeme ile Ömür Boyu Erişim',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '399 TL',
              style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Features column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        features
                            .map(
                              (f) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.greenAccent,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        f,
                                        style: GoogleFonts.outfit(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
                const SizedBox(width: 24),
                // Laws column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        laws
                            .map(
                              (law) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.gavel,
                                      color: Colors.amberAccent,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        law,
                                        style: GoogleFonts.outfit(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEB4C89),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () async {
                final uri = Uri.parse(url);
                if (kIsWeb) {
                  html.window.open(uri.toString(), '_blank');
                } else {
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.platformDefault);
                  } else {
                    debugPrint("Link açılamadı: $url");
                  }
                }
              },
              child: Text(
                'Mağazaya Git',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    // EN ÜSTE (utils gibi bir yere) EKLE
    EdgeInsets responsivePadding(bool isMobile) =>
        EdgeInsets.symmetric(horizontal: isMobile ? 24 : 64, vertical: 60);

    return Container(
      color: Colors.indigo.shade900.withOpacity(0.2),
      padding: responsivePadding(isMobile),

      child: Column(
        children: [
          Text(
            'KamuCEP Fiyatlandırması',
            style: GoogleFonts.outfit(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          isMobile
              ? Column(
                children: [
                  _buildCard(
                    "Google Play",
                    'assets/images/googleplay.png',
                    'https://play.google.com/store/apps/details?id=com.kamucep.app',
                  ),
                  _buildCard(
                    "App Store",
                    'assets/images/appstore.png',
                    'https://apps.apple.com/tr/app/kamucep/id6670272357?l=tr',
                  ),
                ],
              )
              : Row(
                children: [
                  _buildCard(
                    "Google Play",
                    'assets/images/googleplay.png',
                    'https://play.google.com/store/apps/details?id=com.kamucep.app',
                  ),
                  _buildCard(
                    "App Store",
                    'assets/images/appstore.png',
                    'https://apps.apple.com/tr/app/kamucep/id6670272357?l=tr',
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
