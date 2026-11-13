import 'package:flutter/material.dart';

import '../models/studio.dart';
import 'detail_page.dart';
import 'find_studio_page.dart';
import 'my_bookings_page.dart';
import 'search_result_page.dart';

class HomePage extends StatefulWidget {
  final int initialMenu;

  const HomePage({super.key, this.initialMenu = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int selectedMenu;
  String searchText = '';

  final Set<int> favoriteStudios = {};
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool showScrollTop = false;

  final List<Studio> studios = dummyStudios;

  @override
  void initState() {
    super.initState();
    selectedMenu = widget.initialMenu;
    scrollController.addListener(() {
      final shouldShow = scrollController.offset > 150;
      if (showScrollTop != shouldShow && mounted) {
        setState(() {
          showScrollTop = shouldShow;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  void _navigateToFindStudio() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FindStudioPage()),
    );
  }

  void _navigateToDetail(Studio studio) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(studio: studio)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredStudios = studios.where((studio) {
      final name = studio.name.toLowerCase();
      final location = studio.location.toLowerCase();
      final keyword = searchText.toLowerCase();

      return name.contains(keyword) || location.contains(keyword);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F3),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: selectedMenu == 2
                      ? const MyBookingsContent()
                      : SingleChildScrollView(
                          controller: scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header Dashboard
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  22,
                                  14,
                                  22,
                                  12,
                                ),
                                child: Row(
                                  children: const [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Good morning',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF777777),
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Find your space.',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: -0.8,
                                              color: Color(0xFF182522),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 19,
                                      backgroundColor: Color(0xFFD8F26A),
                                      child: Text(
                                        'KA',
                                        style: TextStyle(
                                          color: Color(0xFF25332C),
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Studio Match Dark Card (Buka Find Me a Studio saat diklik)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                child: GestureDetector(
                                  onTap: _navigateToFindStudio,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1F302F),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Stack(
                                      children: [
                                        // Dekorasi lingkaran hijau di kanan atas
                                        Positioned(
                                          top: -45,
                                          right: -45,
                                          child: Container(
                                            width: 125,
                                            height: 125,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF385040),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -22,
                                          right: -22,
                                          child: Container(
                                            width: 75,
                                            height: 75,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF2B3E32),
                                            ),
                                          ),
                                        ),

                                        // Konten dalam kartu
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            18,
                                            30,
                                            18,
                                            28,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'STUDIO MATCH',
                                                style: TextStyle(
                                                  color: Color(0xFFD8F26A),
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                              const SizedBox(height: 14),
                                              const Text(
                                                'What are you\ncreating today?',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  height: 1.15,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: -0.4,
                                                ),
                                              ),
                                              const SizedBox(height: 22),
                                              Container(
                                                height: 44,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                ),
                                                child: Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.search,
                                                      color: Color(0xFFFF775E),
                                                      size: 20,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Location, date, people...',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.grey,
                                                      size: 13,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Section Title: Studios nearby
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'CURATED FOR YOU',
                                          style: TextStyle(
                                            fontSize: 8.5,
                                            color: Color(0xFF777777),
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Studios nearby',
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: -0.4,
                                            color: Color(0xFF182522),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SearchResultPage(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'See all',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF777777),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Daftar Kartu Studio
                              if (filteredStudios.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Center(
                                    child: Text(
                                      'Studio tidak ditemukan.',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                )
                              else
                                ...filteredStudios.map((studio) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      22,
                                      0,
                                      22,
                                      14,
                                    ),
                                    child: _buildStudioCard(studio),
                                  );
                                }),

                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                ),

                // Navigasi Bawah
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Color(0xFFEDE8E1), width: 0.8),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    top: 9,
                    bottom: MediaQuery.of(context).padding.bottom > 0
                        ? (MediaQuery.of(context).padding.bottom * 0.7)
                        : 8,
                  ),
                  child: Row(
                    children: [
                      _buildMenuItem(_NavIconType.home, 'Home', 0),
                      _buildMenuItem(_NavIconType.browse, 'Browse', 1),
                      _buildMenuItem(_NavIconType.bookings, 'My Bookings', 2),
                      _buildMenuItem(_NavIconType.profile, 'Profile', 3),
                    ],
                  ),
                ),
              ],
            ),

            // Tombol Scroll ke Atas
            if (showScrollTop && selectedMenu == 0)
              Positioned(
                right: 26,
                bottom: 85,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFF182522),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: _scrollToTop,
                    icon: const Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudioCard(Studio studio) {
    final isFavorite = favoriteStudios.contains(studio.id);

    return GestureDetector(
      onTap: () => _navigateToDetail(studio),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  studio.imageUrl,
                  width: double.infinity,
                  height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 140,
                      width: double.infinity,
                      color: const Color(0xFFE7E5DF),
                      child: const Icon(
                        Icons.photo_camera_outlined,
                        size: 32,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 9,
                  left: 9,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      studio.category,
                      style: const TextStyle(
                        fontSize: 8.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF25332C),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 9,
                  right: 9,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            favoriteStudios.remove(studio.id);
                          } else {
                            favoriteStudios.add(studio.id);
                          }
                        });
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 16,
                        color: isFavorite
                            ? const Color(0xFFE53935)
                            : const Color(0xFF25332C),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 13, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    studio.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF182522),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 12,
                        color: Color(0xFF8A8A8A),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        studio.location,
                        style: const TextStyle(
                          fontSize: 9.5,
                          color: Color(0xFF8A8A8A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 1,
                    thickness: 0.6,
                    color: Color(0xFFEAE9E5),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          studio.people,
                          style: const TextStyle(
                            fontSize: 9,
                            color: Color(0xFF8A8A8A),
                          ),
                        ),
                      ),
                      Text(
                        '${studio.price} ${studio.duration}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF182522),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(_NavIconType type, String label, int index) {
    final isSelected = selectedMenu == index;
    final color = isSelected
        ? const Color(0xFFFF5E36)
        : const Color(0xFF8A8F8B);

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedMenu = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchResultPage()),
            );
          } else if (index == 3) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$label - MyStudio'),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNavIcon(type, color),
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(_NavIconType type, Color color) {
    switch (type) {
      case _NavIconType.home:
        return CustomPaint(
          size: const Size(22, 22),
          painter: _HomeIconPainter(color: color),
        );
      case _NavIconType.browse:
        return CustomPaint(
          size: const Size(22, 22),
          painter: _SearchIconPainter(color: color),
        );
      case _NavIconType.bookings:
        return CustomPaint(
          size: const Size(22, 22),
          painter: _CalendarIconPainter(color: color),
        );
      case _NavIconType.profile:
        return CustomPaint(
          size: const Size(22, 22),
          painter: _ProfileIconPainter(color: color),
        );
    }
  }
}

enum _NavIconType { home, browse, bookings, profile }

class _HomeIconPainter extends CustomPainter {
  final Color color;
  _HomeIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Outer house outline: triangle roof + walls + floor
    final path = Path();
    path.moveTo(w * 0.5, h * 0.10);
    path.lineTo(w * 0.12, h * 0.44);
    path.lineTo(w * 0.20, h * 0.44);
    path.lineTo(w * 0.20, h * 0.92);
    path.lineTo(w * 0.80, h * 0.92);
    path.lineTo(w * 0.80, h * 0.44);
    path.lineTo(w * 0.88, h * 0.44);
    path.close();
    canvas.drawPath(path, paint);

    // Inner door
    final door = Path();
    door.moveTo(w * 0.39, h * 0.92);
    door.lineTo(w * 0.39, h * 0.60);
    door.lineTo(w * 0.61, h * 0.60);
    door.lineTo(w * 0.61, h * 0.92);
    canvas.drawPath(door, paint);
  }

  @override
  bool shouldRepaint(covariant _HomeIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _SearchIconPainter extends CustomPainter {
  final Color color;
  _SearchIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // Glass circle
    canvas.drawCircle(Offset(w * 0.44, h * 0.44), w * 0.27, paint);

    // Handle
    canvas.drawLine(
      Offset(w * 0.63, h * 0.63),
      Offset(w * 0.86, h * 0.86),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _SearchIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _CalendarIconPainter extends CustomPainter {
  final Color color;
  _CalendarIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Body
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.15, h * 0.22, w * 0.70, h * 0.70),
      const Radius.circular(3.5),
    );
    canvas.drawRRect(rrect, paint);

    // 2 Top Rings
    canvas.drawLine(
      Offset(w * 0.34, h * 0.10),
      Offset(w * 0.34, h * 0.25),
      paint,
    );
    canvas.drawLine(
      Offset(w * 0.66, h * 0.10),
      Offset(w * 0.66, h * 0.25),
      paint,
    );

    // Header divider line
    canvas.drawLine(
      Offset(w * 0.15, h * 0.42),
      Offset(w * 0.85, h * 0.42),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CalendarIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _ProfileIconPainter extends CustomPainter {
  final Color color;
  _ProfileIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // Head
    canvas.drawCircle(Offset(w * 0.5, h * 0.34), w * 0.18, paint);

    // Shoulders
    final path = Path();
    path.moveTo(w * 0.18, h * 0.90);
    path.cubicTo(w * 0.20, h * 0.63, w * 0.80, h * 0.63, w * 0.82, h * 0.90);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ProfileIconPainter oldDelegate) =>
      oldDelegate.color != color;
}
