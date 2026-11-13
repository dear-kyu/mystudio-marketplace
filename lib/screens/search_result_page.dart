import 'package:flutter/material.dart';

import '../models/studio.dart';
import 'detail_page.dart';

class SearchResultPage extends StatefulWidget {
  final String location;
  final String date;
  final String time;
  final String people;
  final String cooling;

  const SearchResultPage({
    super.key,
    this.location = 'Kemang',
    this.date = '23 May',
    this.time = '11:00 - 2 hr',
    this.people = '4 people',
    this.cooling = 'Air conditioning',
  });

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final Set<int> _favoriteIndexes = {};

  String _selectedSort = 'Best match';
  final List<String> _sortOptions = [
    'Best match',
    'Price: Low to High',
    'Price: High to Low',
  ];

  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  final List<Studio> _studios = dummyStudios;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 200) {
        if (!_showBackToTopButton) {
          setState(() {
            _showBackToTopButton = true;
          });
        }
      } else {
        if (_showBackToTopButton) {
          setState(() {
            _showBackToTopButton = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
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
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F4),
      floatingActionButton: _showBackToTopButton
          ? SizedBox(
              width: 44,
              height: 44,
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                backgroundColor: const Color(0xFF222B2E),
                elevation: 4,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            )
          : null,
      body: SafeArea(
        bottom: false,
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Tombol Back (Kembali)
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE0DDD7),
                      width: 1,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Color(0xFF1E1E1E),
                      size: 22,
                    ),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // Kategori: STUDIO MATCH
                    Text(
                      'STUDIO MATCH',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                        color: Color(0xFF8C877D),
                      ),
                    ),
                    SizedBox(height: 2),
                    // Judul: Hasil Pencarian Studio
                    Text(
                      'Hasil Pencarian Studio',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Kartu Gelap Ringkasan Filter Pencarian
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF222B2E),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Filter Lokasi
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color: Color(0xFFB0B8BA),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.location,
                            style: const TextStyle(
                              color: Color(0xFFB0B8BA),
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      // Filter Tanggal
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 15,
                            color: Color(0xFFB0B8BA),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.date,
                            style: const TextStyle(
                              color: Color(0xFFB0B8BA),
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      // Filter Jam & Durasi
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 15,
                            color: Color(0xFFB0B8BA),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.time,
                            style: const TextStyle(
                              color: Color(0xFFB0B8BA),
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      // Filter Jumlah Orang
                      const Icon(
                        Icons.people_outline,
                        size: 15,
                        color: Color(0xFFB0B8BA),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.people,
                        style: const TextStyle(
                          color: Color(0xFFB0B8BA),
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Filter Fasilitas AC
                      const Icon(
                        Icons.ac_unit,
                        size: 14,
                        color: Color(0xFF67D8E8),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.cooling,
                        style: const TextStyle(
                          color: Color(0xFFB0B8BA),
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      // Tombol Edit
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF333E42),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Label: MATCHING YOUR REQUEST
            const Text(
              'MATCHING YOUR REQUEST',
              style: TextStyle(
                fontSize: 8.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.6,
                color: Color(0xFF8C877D),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Teks Total Studio
                const Text(
                  '12 studios found',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
                // Dropdown Urutan
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedSort,
                    alignment: AlignmentDirectional.centerEnd,
                    borderRadius: BorderRadius.circular(14),
                    dropdownColor: Colors.white,
                    elevation: 3,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 15,
                      color: Color(0xFF757575),
                    ),
                    isDense: true,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w500,
                    ),
                    selectedItemBuilder: (BuildContext context) {
                      return _sortOptions.map((String value) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList();
                    },
                    items: _sortOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF555555),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedSort = newValue;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Banner Info Hasil Cocok (Centang Hijau)
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE2F4EC),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.check, color: Color(0xFF1F8063), size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'These studios match your location, capacity, cooling, budget, date, time, and duration.',
                      style: TextStyle(
                        color: Color(0xFF1F8063),
                        fontSize: 9.5,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Daftar Studio Cards
            ..._studios.asMap().entries.map((entry) {
              final index = entry.key;
              final studio = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: _buildStudioCard(studio, index),
              );
            }),

            const SizedBox(height: 10),

            // Teks Keterangan Footer di Bawah Halaman
            const Center(
              child: Text(
                'Results are based on your request. Select a studio to view its details before\nchecking the schedule.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 8.5,
                  color: Color(0xFF8C867D),
                  height: 1.35,
                  letterSpacing: -0.15,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Fungsi Pembuat Kartu Studio (Studio Card)
  Widget _buildStudioCard(Studio studio, int index) {
    final isFavorite = _favoriteIndexes.contains(index);

    return GestureDetector(
      onTap: () => _navigateToDetail(studio),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFFEFECE6), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Foto / Gambar Studio
                SizedBox(
                  height: 195,
                  width: double.infinity,
                  child: Image.network(
                    studio.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFEDE9E3),
                        child: Center(
                          child: Text(
                            studio.name,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Badge Persentase Cocok (98% MATCH)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4F84B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    child: Text(
                      studio.matchPercentage,
                      style: const TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.4,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Nama Studio (Judul)
                      Text(
                        studio.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      // Tombol Favorite / Love
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: isFavorite
                              ? const Color(0xFFE53935)
                              : const Color(0xFF222222),
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            if (isFavorite) {
                              _favoriteIndexes.remove(index);
                            } else {
                              _favoriteIndexes.add(index);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Lokasi Studio (Kemang, Jakarta)
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Color(0xFF8A8A8A),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        studio.location,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF8A8A8A),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Tag Fasilitas (8 people, AC, 6 facilities)
                  Row(
                    children: [
                      _buildTag(studio.people),
                      const SizedBox(width: 6),
                      _buildTag(studio.cooling),
                      const SizedBox(width: 6),
                      _buildTag('${studio.facilities.length} facilities'),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Titik Hijau & Status Ketersediaan
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF00B368),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            studio.availableTime,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF00834C),
                            ),
                          ),
                        ],
                      ),
                      // Harga & Durasi Sewa
                      Row(
                        children: [
                          Text(
                            studio.price,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          Text(
                            studio.duration,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF8A8A8A),
                            ),
                          ),
                        ],
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

  Widget _buildTag(String tag) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1EFEA),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4.5),
      child: Text(
        tag,
        style: const TextStyle(
          color: Color(0xFF736F67),
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
