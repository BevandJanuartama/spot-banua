import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final List<String> eventImages = [
    'assets/images/event/1.png',
    'assets/images/event/2.png',
    'assets/images/event/3.png',
  ];

  final List<Map<String, dynamic>> destinations = [
    {
      'image': '../assets/images/effect/horizontal/tahura.png',
      'title': 'Tahura\nBanjarbaru',
      'rating': 4.9,
    },
    {
      'image': '../assets/images/effect/horizontal/kiram.png',
      'title': 'Kiram\nBanjarbaru',
      'rating': 4.9,
    },
    {
      'image': '../assets/images/effect/horizontal/vanderpilj.png',
      'title': 'Taman Van\nDer Pijl',
      'rating': 4.9,
    },
  ];

  String selectedTab = 'Banjarbaru';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: ListView(
          children: [
            // Header
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Alamat dan avatar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.deepPurple),
                          const SizedBox(width: 5),
                          Text(
                            'Karang Anyar 3, Banjarbaru',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage('assets/images/profile.jpg'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Discover',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Event images scroll horizontal
                  SizedBox(
                    height: 247,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: eventImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 0 : 8.0,
                            right: index == eventImages.length - 1 ? 0 : 8.0,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              eventImages[index],
                              width: MediaQuery.of(context).size.width * 0.91,
                              height: 247,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Search box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  style: GoogleFonts.poppins(),
                  decoration: InputDecoration(
                    hintText: 'Found Place...',
                    hintStyle: GoogleFonts.poppins(color: Colors.grey),
                    border: InputBorder.none,
                    suffixIcon: const Icon(Icons.search, color: Colors.purple),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Tab pilihan kota
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: ['Banjarbaru', 'Banjarmasin', 'Lainnya'].map((tab) {
                  final isSelected = tab == selectedTab;
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = tab;
                        });
                      },
                      child: Text(
                        tab,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.black : Colors.grey,
                          decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // Judul top destination
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Top Destination',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Scroll horizontal card destinasi
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: destinations.map((dest) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Stack(
                          children: [
                            _buildDestinationCard(
                              image: dest['image'],
                              title: dest['title'],
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: const Icon(Icons.favorite, color: Colors.red),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star, color: Colors.white, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${dest['rating']}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationCard({required String image, required String title}) {
    return SizedBox(
      width: 160,
      height: 200,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              image,
              width: 160,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 160,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
