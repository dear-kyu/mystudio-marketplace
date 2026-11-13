import 'package:flutter/material.dart';

import 'payment.dart';

// ---------------------------------------------------------------------------
// Halaman Payment Successful ("You're booked!")
// ---------------------------------------------------------------------------
class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  static const _roles = ['Customer', 'Owner', 'Admin'];

  static const String _imageUrl =
      'https://images.unsplash.com/photo-1586232702178-f044c5f4d4b7?auto=format&fit=crop&w=1000&q=85';

  String _role = 'Customer';

  void _openAssistant() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Membuka WhatsApp Booking Assistant')),
    );
  }

  void _backToHome() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RoleSwitcherBar(
            roles: _roles,
            selected: _role,
            onChanged: (r) => setState(() => _role = r),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 55, 20, 32),
              child: Column(
                children: [
                  const _SuccessBadge(),
                  const SizedBox(height: 10),
                  const Text(
                    'PAYMENT SUCCESSFUL',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.6,
                      color: AppColors.label,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'You’re booked!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      height: 1.15,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Atelier Kecil is ready for you on Friday, 23 May.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.5, color: AppColors.muted),
                  ),
                  const SizedBox(height: 27),
                  const _BookingCard(imageUrl: _imageUrl),
                  const SizedBox(height: 15),
                  const _AssistantNote(),
                  const SizedBox(height: 19),
                  _AssistantButton(onTap: _openAssistant),
                  const SizedBox(height: 17),
                  GestureDetector(
                    onTap: _backToHome,
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Back to home',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Lingkaran hijau + centang + lingkaran lembut di sekelilingnya
// ---------------------------------------------------------------------------
class _SuccessBadge extends StatelessWidget {
  const _SuccessBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 88,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.successSoft,
        shape: BoxShape.circle,
      ),
      child: Container(
        width: 72,
        height: 72,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
        ),
        child: const SizedBox(
          width: 36,
          height: 36,
          child: CustomPaint(painter: _CheckPainter()),
        ),
      ),
    );
  }
}

class _CheckPainter extends CustomPainter {
  const _CheckPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(size.width * 0.21, size.height * 0.52)
      ..lineTo(size.width * 0.43, size.height * 0.73)
      ..lineTo(size.width * 0.80, size.height * 0.29);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Kartu ringkasan booking
// ---------------------------------------------------------------------------
class _BookingCard extends StatelessWidget {
  const _BookingCard({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 128,
            width: double.infinity,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const _ImagePlaceholder();
              },
              errorBuilder: (context, error, stackTrace) =>
                  const _ImagePlaceholder(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 22, 15, 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.successSoft,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'CONFIRMED',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                      color: AppColors.success,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Atelier Kecil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.6,
                    height: 1.2,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '23 May  ·  11:00–13:00',
                  style: TextStyle(fontSize: 10, color: AppColors.muted),
                ),
                const SizedBox(height: 15),
                const SizedBox(
                  height: 1,
                  width: double.infinity,
                  child: CustomPaint(painter: _DashedLinePainter()),
                ),
                const SizedBox(height: 12),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Booking ID',
                      style: TextStyle(fontSize: 9.5, color: AppColors.muted),
                    ),
                    Text(
                      '#MYS-2048',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter();

  static const double _dash = 3;
  static const double _gap = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE6E2DA)
      ..strokeWidth = 1;

    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + _dash, 0), paint);
      x += _dash + _gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF2F2F0), Color(0xFFDADAD6)],
        ),
      ),
      child: const Stack(
        children: [
          Positioned(
            left: 14,
            bottom: 4,
            child: Icon(Icons.local_florist_outlined,
                size: 56, color: Color(0xFF2F4A2F)),
          ),
          Positioned(
            right: 12,
            bottom: 4,
            child: Icon(Icons.park_outlined,
                size: 64, color: Color(0xFF1F3A1F)),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Kotak "Booking Assistant is ready"
// ---------------------------------------------------------------------------
class _AssistantNote extends StatelessWidget {
  const _AssistantNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.chat_bubble_outline_rounded,
            size: 18,
            color: AppColors.ink,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Booking Assistant is ready',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Get reservation help directly through WhatsApp',
                  style: TextStyle(fontSize: 9.5, color: AppColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tombol "Open booking assistant >"
// ---------------------------------------------------------------------------
class _AssistantButton extends StatelessWidget {
  const _AssistantButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.28),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Open booking assistant',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
