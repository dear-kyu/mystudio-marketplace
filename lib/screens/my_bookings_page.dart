import 'package:flutter/material.dart';

import 'booking_confirmed_page.dart';

// Isi halaman My Bookings (ditampilkan di dalam HomeScreen)
class MyBookingsContent extends StatefulWidget {
  const MyBookingsContent({super.key});

  @override
  State<MyBookingsContent> createState() => _MyBookingsContentState();
}

class _MyBookingsContentState extends State<MyBookingsContent> {
  // 0 = Upcoming, 1 = Past, 2 = Cancelled
  int selectedTab = 0;

  final List<String> tabs = ['Upcoming', 'Past', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul halaman
          const Padding(
            padding: EdgeInsets.fromLTRB(22, 18, 22, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOUR SCHEDULE',
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 1.2,
                    color: Color(0xFF777777),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'My bookings',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.8,
                    color: Color(0xFF182522),
                  ),
                ),
              ],
            ),
          ),

          // Tab Upcoming / Past / Cancelled
          Row(children: [_buildTab(0), _buildTab(1), _buildTab(2)]),

          const SizedBox(height: 16),

          // Isi tab
          if (selectedTab == 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: _buildBookingCard(),
            )
          else
            Padding(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: Text(
                  'No ${tabs[selectedTab].toLowerCase()} bookings.',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF777777),
                  ),
                ),
              ),
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Satu tab
  Widget _buildTab(int index) {
    final isSelected = selectedTab == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? const Color(0xFFFF775E)
                    : const Color(0xFFE3E1DC),
                width: isSelected ? 2 : 1,
              ),
            ),
          ),
          child: Text(
            tabs[index],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF182522),
            ),
          ),
        ),
      ),
    );
  }

  // Kartu booking
  Widget _buildBookingCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAE9E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge CONFIRMED dan kode booking
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F4EA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'CONFIRMED',
                  style: TextStyle(
                    fontSize: 7.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: Color(0xFF2E7D52),
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                '#MYS-2048',
                style: TextStyle(fontSize: 8, color: Color(0xFF999999)),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Foto studio
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://images.unsplash.com/photo-1586232702178-f044c5f4d4b7?auto=format&fit=crop&w=1000&q=85',
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120,
                  width: double.infinity,
                  color: const Color(0xFFE7E5DF),
                  child: const Icon(Icons.photo_camera_outlined),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Nama studio
          const Text(
            'Atelier Kecil',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF182522),
            ),
          ),

          const SizedBox(height: 10),

          // Tanggal + jam + lokasi
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE9E3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '23',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF775E),
                      ),
                    ),
                    Text(
                      'MAY',
                      style: TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFF775E),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Friday, 11:00–13:00',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF182522),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Kemang, South Jakarta',
                      style: TextStyle(fontSize: 9, color: Color(0xFF777777)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Tombol Open Booking Guide
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingConfirmedPage(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF182522),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chevron_right, color: Colors.white, size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Open Booking Guide',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
