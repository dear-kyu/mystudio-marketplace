import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_page.dart';

// Halaman Booking Confirmed
class BookingConfirmedPage extends StatelessWidget {
  const BookingConfirmedPage({super.key});

  // Fungsi untuk membuka link Maps dan WhatsApp
  Future<void> _bukaLink(String alamat) async {
    final Uri uri = Uri.parse(alamat);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // Fungsi untuk membuka Google Maps
  Future<void> _bukaMaps() async {
    await _bukaLink(
      'https://www.google.com/maps/search/?api=1&query=Jl.+Kemang+Raya+No.+12+Kemang+Jakarta+Selatan',
    );
  }

  // Fungsi untuk membuka chat WhatsApp
  Future<void> _bukaWhatsApp() async {
    await _bukaLink(
      'https://wa.me/6281234567890?text=Hello,%20I%20want%20to%20ask%20about%20my%20booking%20%23MYS-2048',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F3),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildHeader(context), _buildBody(context)],
        ),
      ),
    );
  }

  // Bagian atas: tombol kembali, judul, dan kartu studio
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xFF1F302F)),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -60,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF34462E), width: 16),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).padding.top + 12,
              20,
              24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3A4C4A),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                const Row(
                  children: [
                    Icon(Icons.check, color: Color(0xFFD8F26A), size: 14),
                    SizedBox(width: 6),
                    Text(
                      'BOOKING CONFIRMED',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Color(0xFFD8F26A),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                const Text(
                  'Your studio day,\nmade simple.',
                  style: TextStyle(
                    fontSize: 30,
                    height: 1.15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.8,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Everything you need for a smooth session is right here.',
                  style: TextStyle(fontSize: 12, color: Color(0xFFB8C4C0)),
                ),

                const SizedBox(height: 16),

                // Kartu studio
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B3E3C),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFF3A4C4A)),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1586232702178-f044c5f4d4b7?auto=format&fit=crop&w=300&q=80',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 50,
                              height: 50,
                              color: const Color(0xFF3A4C4A),
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'YOUR STUDIO',
                              style: TextStyle(
                                fontSize: 9,
                                letterSpacing: 0.8,
                                color: Color(0xFF9FB0AB),
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Atelier Kecil',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Hosted by Media Studio',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF9FB0AB),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Badge CONFIRMED
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDDF3E7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'CONFIRMED',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B8A5A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bagian bawah: lokasi, informasi booking, tips, dan tombol
  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kotak lokasi dan tombol View Map
          _buildBox(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE9E3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.location_on_outlined,
                      size: 20,
                      color: Color(0xFFFF775E),
                    ),
                  ),

                  const SizedBox(width: 10),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LOCATION',
                          style: TextStyle(
                            fontSize: 7,
                            letterSpacing: 0.8,
                            color: Color(0xFF999999),
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Jl. Kemang Raya No. 12',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF182522),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Kemang, Mampang Prapatan, South Jakarta',
                          style: TextStyle(
                            fontSize: 8,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ],
                    ),
                  ),

                  _buildGaris(),

                  InkWell(
                    onTap: _bukaMaps,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'View',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF775E),
                              ),
                            ),
                            Text(
                              'map',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF775E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Kotak Date, Time, dan Paid
          _buildBox(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  _buildInfo('DATE', '23 May', 'Friday'),
                  _buildGaris(),
                  _buildInfo('TIME', '11:00–13:00', '2 hours'),
                  _buildGaris(),
                  _buildInfo('PAID', 'Rp25,000', 'Payment received'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 22),

          // Section 01
          _buildSectionTitle('01', 'BEFORE YOU GO', 'Prepare for your session'),

          const SizedBox(height: 12),

          // Kotak tips dengan garis pembatas
          _buildBox(
            child: Column(
              children: [
                _buildTipRow(
                  Icons.access_time,
                  'Arrive 10 minutes early',
                  'Allow time for studio orientation before your session.',
                ),

                // Garis pembatas tipis seperti referensi
                const Padding(
                  padding: EdgeInsets.only(left: 44, top: 8, bottom: 8),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFEAE9E5),
                  ),
                ),

                _buildTipRow(
                  Icons.group_outlined,
                  'Maximum 8 guests',
                  'Share the guest count with the owner in advance.',
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // Section 02
          _buildSectionTitle('02', 'ACCESS & RULES', 'Know before arrival'),

          const SizedBox(height: 12),

          _buildBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Access',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF182522),
                  ),
                ),

                const SizedBox(height: 4),

                // Nomor booking dibuat tebal
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 9,
                      height: 1.35,
                      color: Color(0xFF777777),
                    ),
                    children: [
                      TextSpan(
                        text: 'Enter through the glass door beside Kopi Kecil. Tell reception your booking is ',
                      ),
                      TextSpan(
                        text: '#MYS-2048.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF182522),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                const Divider(height: 1, color: Color(0xFFEAE9E5)),

                const SizedBox(height: 10),

                const Text(
                  'Studio rules',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF182522),
                  ),
                ),

                const SizedBox(height: 4),

                // Deskripsi Studio rules seluruhnya normal
                const Text(
                  'Indoor shoes only. Food and drinks stay in the lounge. Return movable equipment after use.',
                  style: TextStyle(
                    fontSize: 9,
                    height: 1.35,
                    color: Color(0xFF777777),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Notice informasi bantuan
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFECF7F2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Have questions about your booking?',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B8A5A),
                  ),
                ),

                const SizedBox(height: 5),

                // Bagian WhatsApp dibuat tebal
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 9.5,
                      height: 1.35,
                      color: Color(0xFF5E6B66),
                    ),
                    children: [
                      TextSpan(
                        text: 'If you need any help or have questions before your session, feel free to contact the ',
                      ),
                      TextSpan(
                        text: 'Booking Assistant via WhatsApp.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F302F),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Tombol WhatsApp
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _bukaWhatsApp,
              icon: const Icon(Icons.chat_bubble_outline, size: 18),
              label: const Text(
                'Chat Booking Assistant via WhatsApp',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B8A5A),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Tombol kembali ke My Bookings
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(initialMenu: 2),
                ),
                (route) => false,
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFEAE9E5)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View My Bookings',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF775E),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 16, color: Color(0xFFFF775E)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Kotak putih dengan border
  Widget _buildBox({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEAE9E5)),
      ),
      child: child,
    );
  }

  // Garis tegak pemisah antar kolom
  Widget _buildGaris() {
    return const VerticalDivider(
      width: 20,
      thickness: 1,
      color: Color(0xFFEAE9E5),
    );
  }

  // Kolom informasi Date, Time, dan Paid
  Widget _buildInfo(String label, String value, String note) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 7,
              letterSpacing: 0.8,
              color: Color(0xFF999999),
            ),
          ),

          const SizedBox(height: 3),

          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF182522),
            ),
          ),

          const SizedBox(height: 2),

          Text(
            note,
            style: const TextStyle(fontSize: 7, color: Color(0xFF777777)),
          ),
        ],
      ),
    );
  }

  // Judul section dengan bulatan nomor
  Widget _buildSectionTitle(String number, String label, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFF1F302F),
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD8F26A),
            ),
          ),
        ),

        const SizedBox(width: 10),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                color: Color(0xFFFF775E),
              ),
            ),

            const SizedBox(height: 3),

            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF182522),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Baris tips dengan ikon, judul, dan keterangan
  Widget _buildTipRow(IconData icon, String title, String desc) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F1EC),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF182522)),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF182522),
                ),
              ),

              const SizedBox(height: 3),

              Text(
                desc,
                style: const TextStyle(
                  fontSize: 9,
                  height: 1.3,
                  color: Color(0xFF777777),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
