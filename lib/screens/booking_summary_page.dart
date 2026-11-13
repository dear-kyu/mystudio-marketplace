import 'package:flutter/material.dart';

import 'payment.dart';

class BookingSummaryPage extends StatelessWidget {
  final String studioName;
  final String studioLocation;
  final String dateText;
  final String timeText;
  final String durationText;
  final String guestsText;
  final int rentalPrice;
  final int serviceFee;
  final String studioImage;

  const BookingSummaryPage({
    super.key,
    this.studioName = 'Atelier Kecil',
    this.studioLocation = 'Nadia Studio · Kemang',
    this.dateText = 'Friday, 23 May 2025',
    this.timeText = '11:00–13:00',
    this.durationText = '2 hours',
    this.guestsText = '4 people',
    this.rentalPrice = 90000,
    this.serviceFee = 5000,
    this.studioImage = 'https://images.unsplash.com/photo-1586232702178-f044c5f4d4b7?auto=format&fit=crop&w=1000&q=85',
  });

  static const Color orange = Color(0xFFFF5E36);
  static const Color darkText = Color(0xFF16221F);
  static const Color greyText = Color(0xFF8A8F8B);
  static const Color tealGreen = Color(0xFF00A86B);
  static const Color dividerColor = Color(0xFFF1EFEA);

  String _formatRupiah(int value) {
    String angka = value.toString();
    String hasil = '';
    for (int i = 0; i < angka.length; i++) {
      if (i > 0 && (angka.length - i) % 3 == 0) {
        hasil += '.';
      }
      hasil += angka[i];
    }
    return 'Rp$hasil';
  }

  @override
  Widget build(BuildContext context) {
    final totalPayment = rentalPrice + serviceFee;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Back Button + Title
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE5E2DA)),
                      ),
                      child: const Icon(
                        Icons.chevron_left,
                        color: darkText,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'REVIEW BOOKING',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          color: greyText,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Booking summary',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: darkText,
                          letterSpacing: -0.6,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Card 1: Studio Info
              _buildWhiteCard(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        studioImage,
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 72,
                          height: 72,
                          color: const Color(0xFFE8E6DF),
                          child: const Icon(Icons.photo, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: tealGreen,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'AVAILABLE',
                                style: TextStyle(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  color: tealGreen,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            studioName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: darkText,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            studioLocation,
                            style: const TextStyle(
                              fontSize: 11,
                              color: greyText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Card 2: Date, Time & Duration, Guests
              _buildWhiteCard(
                child: Column(
                  children: [
                    _buildDetailRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'DATE',
                      value: dateText,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 0.7,
                      color: dividerColor,
                      indent: 58,
                    ),
                    _buildDetailRow(
                      icon: Icons.access_time_outlined,
                      label: 'TIME & DURATION',
                      value: '$timeText · $durationText',
                    ),
                    const Divider(
                      height: 1,
                      thickness: 0.7,
                      color: dividerColor,
                      indent: 58,
                    ),
                    _buildDetailRow(
                      icon: Icons.people_outline,
                      label: 'GUESTS',
                      value: guestsText,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Card 3: Automatic Availability Check
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5EE),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AUTOMATIC AVAILABILITY CHECK',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.9,
                        color: Color(0xFF1E6C58),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _CheckItem(text: 'Within operating hours'),
                              SizedBox(height: 9),
                              _CheckItem(text: 'No temporary payment hold'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _CheckItem(text: 'No blocked schedule'),
                              SizedBox(height: 9),
                              _CheckItem(text: 'No confirmed reservation'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Card 4: Payment Breakdown
              _buildWhiteCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildPriceRow(
                      label: 'Studio rental · $durationText',
                      amount: rentalPrice,
                    ),
                    const SizedBox(height: 10),
                    _buildPriceRow(label: 'Service fee', amount: serviceFee),
                    const SizedBox(height: 13),
                    const Divider(
                      height: 1,
                      thickness: 0.7,
                      color: Color(0xFFEBE8E1),
                    ),
                    const SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total payment',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: darkText,
                          ),
                        ),
                        Text(
                          _formatRupiah(totalPayment),
                          style: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            color: darkText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Notice Card: Hold slot notice
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4DF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.access_time, size: 15, color: Color(0xFF8C6D32)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Your slot will be temporarily held when you continue. It returns to availability if payment expires.',
                        style: TextStyle(
                          fontSize: 9.5,
                          height: 1.35,
                          color: Color(0xFF755B25),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Hold slot & pay Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Hold slot & pay',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.chevron_right, size: 18),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Pembuat Kartu Putih Bersih
  Widget _buildWhiteCard({required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  // Helper Baris Detail (Tanggal, Jam, Tamu)
  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F1EC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 17, color: const Color(0xFF555C58)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 8.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.9,
                  color: greyText,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper Baris Rincian Harga
  Widget _buildPriceRow({required String label, required int amount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF555C58)),
        ),
        Text(
          _formatRupiah(amount),
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: darkText,
          ),
        ),
      ],
    );
  }
}

class _CheckItem extends StatelessWidget {
  final String text;

  const _CheckItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check, size: 13, color: Color(0xFF00A86B)),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 9.5,
              color: Color(0xFF265A4B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
