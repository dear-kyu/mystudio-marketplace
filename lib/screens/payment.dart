import 'dart:async';

import 'package:flutter/material.dart';

import 'payment_success.dart';

// ---------------------------------------------------------------------------
// Warna (diambil dari screenshot)
// ---------------------------------------------------------------------------
class AppColors {
  static const background = Color(0xFFF8F7F3);
  static const topBar = Color(0xFFE9E6DF);
  static const ink = Color(0xFF1C1B1A);
  static const muted = Color(0xFF86857F);
  static const label = Color(0xFF7C7D76);
  static const border = Color(0xFFEFEEE9);
  static const iconBox = Color(0xFFF0EFEB);
  static const accent = Color(0xFFFF6A4D);
  static const warnFill = Color(0xFFFFF5D9);
  static const warnText = Color(0xFF8F6A1C);
  static const warnSub = Color(0xFF987A45);
  static const dashed = Color(0xFFD2CDC3);
  static const radioBorder = Color(0xFFDDD9D1);
  static const success = Color(0xFF14795A);
  static const successSoft = Color(0xFFE2F2EB);
}

// ---------------------------------------------------------------------------
// Data metode pembayaran
// ---------------------------------------------------------------------------
class _PaymentMethod {
  const _PaymentMethod({
    required this.title,
    required this.subtitle,
    this.icon,
    this.letter,
  });

  final String title;
  final String subtitle;
  final IconData? icon;
  final String? letter;
}

// ---------------------------------------------------------------------------
// Halaman Payment
// ---------------------------------------------------------------------------
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  static const _roles = ['Customer', 'Owner', 'Admin'];

  static const _methods = [
    _PaymentMethod(
      title: 'Bank transfer',
      subtitle: 'Virtual account',
      letter: 'B',
    ),
    _PaymentMethod(
      title: 'Digital wallet',
      subtitle: 'GoPay, OVO, DANA',
      icon: Icons.account_balance_wallet_outlined,
    ),
    _PaymentMethod(
      title: 'Credit / debit card',
      subtitle: 'Visa, Mastercard',
      icon: Icons.credit_card_outlined,
    ),
  ];

  static const String _total = 'Rp95.000';

  String _role = 'Customer';
  int _selected = 0;

  int _secondsLeft = 9 * 60 + 42;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 0) {
        t.cancel();
        return;
      }
      setState(() => _secondsLeft--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timeText {
    final m = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _pay() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const PaymentSuccessPage()));
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
              padding: const EdgeInsets.fromLTRB(20, 31, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Header(),
                  const SizedBox(height: 27),
                  _HoldBanner(timeText: _timeText),
                  const SizedBox(height: 30),
                  const _TotalSection(total: _total),
                  const SizedBox(height: 37),
                  const Text(
                    'PAYMENT METHOD',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.3,
                      color: AppColors.label,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (int i = 0; i < _methods.length; i++) ...[
                    _MethodTile(
                      method: _methods[i],
                      selected: _selected == i,
                      onTap: () => setState(() => _selected = i),
                    ),
                    if (i != _methods.length - 1) const SizedBox(height: 9),
                  ],
                  const SizedBox(height: 24),
                  const _SecureNote(),
                  const SizedBox(height: 18),
                  _PayButton(
                    label: 'Pay $_total',
                    onTap: _secondsLeft > 0 ? _pay : null,
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
// Bar atas "VIEWING AS" + kapsul pilihan peran
// ---------------------------------------------------------------------------
class RoleSwitcherBar extends StatelessWidget {
  const RoleSwitcherBar({
    super.key,
    required this.roles,
    required this.selected,
    required this.onChanged,
  });

  final List<String> roles;
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 57,
      padding: const EdgeInsets.fromLTRB(12, 5, 10, 11),
      color: AppColors.topBar,
      child: Row(
        children: [
          const Text(
            'VIEWING AS',
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: AppColors.label,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final r in roles)
                  GestureDetector(
                    onTap: () => onChanged(r),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        color: r == selected
                            ? AppColors.topBar
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Text(
                        r,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
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
// Header: tombol back + "SECURE CHECKOUT" + "Payment"
// ---------------------------------------------------------------------------
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 14,
              color: AppColors.ink,
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SECURE CHECKOUT',
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.3,
                color: AppColors.label,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Payment',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
                height: 1.1,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Banner "Slot held for you"
// ---------------------------------------------------------------------------
class _HoldBanner extends StatelessWidget {
  const _HoldBanner({required this.timeText});

  final String timeText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.warnFill,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.schedule_rounded,
            size: 18,
            color: AppColors.warnText,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Slot held for you',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.warnText,
                  ),
                ),
                const SizedBox(height: 3),
                Text.rich(
                  TextSpan(
                    text: 'Complete payment within ',
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.warnSub,
                    ),
                    children: [
                      TextSpan(
                        text: timeText,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.warnText,
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
}

// ---------------------------------------------------------------------------
// Total pembayaran
// ---------------------------------------------------------------------------
class _TotalSection extends StatelessWidget {
  const _TotalSection({required this.total});

  final String total;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text(
            'Total payment',
            style: TextStyle(fontSize: 11, color: AppColors.muted),
          ),
          const SizedBox(height: 8),
          Text(
            total,
            style: const TextStyle(
              fontSize: 31,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
              height: 1.15,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Atelier Kecil  ·  23 May, 11:00',
            style: TextStyle(fontSize: 10, color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Kartu metode pembayaran
// ---------------------------------------------------------------------------
class _MethodTile extends StatelessWidget {
  const _MethodTile({
    required this.method,
    required this.selected,
    required this.onTap,
  });

  final _PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Tinggi kartu dibuat tetap: border tebal (terpilih) mengurangi padding.
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: selected ? 10 : 11,
          vertical: selected ? 10 : 11,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.border,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.iconBox,
                borderRadius: BorderRadius.circular(10),
              ),
              child: method.letter != null
                  ? Text(
                      method.letter!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    )
                  : Icon(method.icon, size: 18, color: AppColors.ink),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.title,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    method.subtitle,
                    style: const TextStyle(
                      fontSize: 9.5,
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            _RadioDot(selected: selected),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? AppColors.accent : Colors.white,
        border: selected
            ? null
            : Border.all(color: AppColors.radioBorder, width: 1.5),
      ),
      child: selected
          ? const Icon(Icons.check_rounded, size: 12, color: Colors.white)
          : null,
    );
  }
}

// ---------------------------------------------------------------------------
// Catatan keamanan (kotak garis putus-putus)
// ---------------------------------------------------------------------------
class _SecureNote extends StatelessWidget {
  const _SecureNote();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const _DashedRRectPainter(color: AppColors.dashed, radius: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        child: const Row(
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              size: 16,
              color: AppColors.muted,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Your payment is securely held by MyStudio until the '
                'reservation is completed.',
                style: TextStyle(
                  fontSize: 9.5,
                  height: 1.35,
                  color: AppColors.muted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  const _DashedRRectPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  static const double _dash = 3;
  static const double _gap = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + _dash), paint);
        distance += _dash + _gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter old) =>
      old.color != color || old.radius != radius;
}

// ---------------------------------------------------------------------------
// Tombol "Pay Rp95.000"
// ---------------------------------------------------------------------------
class _PayButton extends StatelessWidget {
  const _PayButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Container(
      height: 53,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: enabled
            ? [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.28),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Material(
        color: enabled ? AppColors.accent : const Color(0xFFD9D4CB),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
