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
  static const Color greyText = Color(0xFF383D3B);
  static const Color tealGreen = Color(0xFF0B6B43);
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

    final header = Row(
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
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.3,
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
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header,
              const SizedBox(height: 22),
              _buildStudioCard(),
              const SizedBox(height: 14),
              _buildDetailsCard(),
              const SizedBox(height: 14),
              _buildAutoCheckCard(),
              const SizedBox(height: 14),
              _buildPaymentCard(totalPayment),
              const SizedBox(height: 14),
              _buildNoticeCard(),
              const SizedBox(height: 18),
              _buildHoldAndPayButton(context),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Card 1: Studio Info
  Widget _buildStudioCard() {
    return _buildWhiteCard(
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
                        fontSize: 10,
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
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  studioLocation,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: greyText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Card 2: Date, Time & Duration, Guests
  Widget _buildDetailsCard() {
    return _buildWhiteCard(
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
    );
  }

  // Card 3: Automatic Availability Check
  Widget _buildAutoCheckCard() {
    return Container(
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
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
              color: Color(0xFF0F4738),
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
    );
  }

  // Card 4: Payment Breakdown
  Widget _buildPaymentCard(int totalPayment) {
    return _buildWhiteCard(
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
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                ),
              ),
              Text(
                _formatRupiah(totalPayment),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: darkText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Notice Card: Hold slot notice
  Widget _buildNoticeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2D6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFDF99), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.access_time, size: 16, color: Color(0xFF6B4800)),
          SizedBox(width: 9),
          Expanded(
            child: Text(
              'Your slot will be temporarily held when you continue. It returns to availability if payment expires.',
              style: TextStyle(
                fontSize: 11.5,
                height: 1.4,
                color: Color(0xFF473000),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Hold slot & pay Button
  Widget _buildHoldAndPayButton(BuildContext context) {
    return SizedBox(
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
                fontSize: 15.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 6),
            Icon(Icons.chevron_right, size: 18),
          ],
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
            child: Icon(icon, size: 17, color: const Color(0xFF262A28)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                  color: greyText,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
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
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF16221F),
          ),
        ),
        Text(
          _formatRupiah(amount),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
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
        const Icon(Icons.check, size: 14, color: Color(0xFF096841)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF0F3E32),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
