import 'package:flutter/material.dart';

import '../models/studio.dart';

// ============================================================================
// DETAIL STUDIO / STUDIO DETAIL
// Dikerjakan oleh: Rita Karmila (162024024)
// ============================================================================
class StudioDetailColors {
  static const background = Color(0xFFF6F3EE);
  static const ink = Color(0xFF1C1B1A);
  static const muted = Color(0xFF6B6863);
  static const border = Color(0xFFE6E1D9);
  static const chipFill = Color(0xFFECE8E1);
  static const green = Color(0xFF1FA463);
  static const blue = Color(0xFF2B4FD8);
  static const lime = Color(0xFFD9F24B);
  static const accent = Color(0xFFFF6A4D);
}

class DetailPage extends StatefulWidget {
  final Studio? studio;

  const DetailPage({
    super.key,
    this.studio,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final Studio _studio;

  @override
  void initState() {
    super.initState();
    _studio = widget.studio ?? dummyStudios[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StudioDetailColors.background,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroImage(
                    current: 1,
                    total: 6,
                    imageUrl: _studio.imageUrl,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _AvailabilityLabel(text: _studio.availableTime.toUpperCase()),
                        const SizedBox(height: 8),
                        Text(
                          _studio.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                            letterSpacing: -0.5,
                            color: StudioDetailColors.ink,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _HostRow(
                          initials: _studio.hostInitials,
                          name: _studio.hostName,
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _InfoChip(
                              icon: Icons.location_on_outlined,
                              label: _studio.location,
                            ),
                            _InfoChip(
                              icon: Icons.groups_outlined,
                              label: _studio.people,
                            ),
                            _InfoChip(
                              icon: Icons.ac_unit,
                              iconColor: const Color(0xFF64B5F6),
                              label: _studio.cooling,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _studio.description,
                          style: const TextStyle(
                            fontSize: 12.5,
                            height: 1.5,
                            color: StudioDetailColors.muted,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(
                          height: 1,
                          color: StudioDetailColors.border,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Facilities',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: StudioDetailColors.ink,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final f in _studio.facilities)
                              _FacilityChip(label: f),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _BottomBookingBar(
            price: _studio.price,
            per: _studio.duration,
            onBookPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xFF1F8063),
                  content: Text(
                    'Slot tersedia untuk ${_studio.name}! Siap melanjutkan ke pembayaran.',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({
    required this.current,
    required this.total,
    required this.imageUrl,
  });

  final int current;
  final int total;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const _StudioPlaceholder();
            },
            errorBuilder: (context, error, stackTrace) =>
                const _StudioPlaceholder(),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 15,
                    color: StudioDetailColors.ink,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
          Positioned(
            right: 14,
            bottom: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                '$current/$total',
                style: const TextStyle(
                  color: StudioDetailColors.ink,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StudioPlaceholder extends StatelessWidget {
  const _StudioPlaceholder();

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
            left: 20,
            bottom: 8,
            child: Icon(
              Icons.local_florist_outlined,
              size: 70,
              color: Color(0xFF2F4A2F),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 8,
            child: Icon(
              Icons.park_outlined,
              size: 90,
              color: Color(0xFF1F3A1F),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 14,
            child: Icon(
              Icons.chair_alt_outlined,
              size: 64,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvailabilityLabel extends StatelessWidget {
  const _AvailabilityLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: StudioDetailColors.green,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 7.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: StudioDetailColors.green,
          ),
        ),
      ],
    );
  }
}

class _HostRow extends StatelessWidget {
  const _HostRow({required this.initials, required this.name});

  final String initials;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: StudioDetailColors.lime,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Hosted by ',
              style: TextStyle(fontSize: 11, color: StudioDetailColors.muted),
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: StudioDetailColors.ink,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    this.icon,
    this.iconColor,
    required this.label,
  });

  final IconData? icon;
  final Color? iconColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: StudioDetailColors.chipFill,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: StudioDetailColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: iconColor ?? StudioDetailColors.ink),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: StudioDetailColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _FacilityChip extends StatelessWidget {
  const _FacilityChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: StudioDetailColors.border),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: StudioDetailColors.ink,
        ),
      ),
    );
  }
}

class _BottomBookingBar extends StatelessWidget {
  const _BottomBookingBar({
    required this.price,
    required this.per,
    required this.onBookPressed,
  });

  final String price;
  final String per;
  final VoidCallback onBookPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: StudioDetailColors.border)),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'From',
                style: TextStyle(fontSize: 9, color: StudioDetailColors.muted),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: StudioDetailColors.ink,
                    ),
                  ),
                  Text(
                    ' $per',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: StudioDetailColors.muted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            height: 38,
            child: ElevatedButton(
              onPressed: onBookPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: StudioDetailColors.accent,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Check availability',
                style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

