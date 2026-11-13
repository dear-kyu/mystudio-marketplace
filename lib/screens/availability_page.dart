import 'package:flutter/material.dart';

import '../models/studio.dart';
import 'booking_summary_page.dart';

class AvailabilityPage extends StatefulWidget {
  final Studio? studio;
  final String? initialDateText;
  final String? initialTime;
  final int? initialDuration;
  final List<int>? availableDurations;

  const AvailabilityPage({
    super.key,
    this.studio,
    this.initialDateText = 'Fri, 23 May',
    this.initialTime = '11:00',
    this.initialDuration = 2,
    this.availableDurations,
  });

  @override
  State<AvailabilityPage> createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  late final Studio _studio;

  // Selected State
  late String _selectedDateText;
  late String _selectedTime;
  late int _selectedDuration;

  // Time Slots
  final List<Map<String, dynamic>> _timeSlots = [
    {'time': '09:00', 'available': false},
    {'time': '10:00', 'available': true},
    {'time': '11:00', 'available': true},
    {'time': '12:00', 'available': true},
    {'time': '13:00', 'available': true},
    {'time': '14:00', 'available': true},
  ];

  // Duration Options (in hours)
  late final List<int> _durations;

  static const Color primaryOrange = Color(0xFFFF5E36);
  static const Color darkInk = Color(0xFF16221F);
  static const Color mutedGrey = Color(0xFF8A8F8B);
  static const Color cardBorder = Color(0xFFEBE8E1);
  static const Color bgSurface = Color(0xFFF7F5F0);
  static const Color greenBrand = Color(0xFF00A86B);
  static const Color darkButtonBg = Color(0xFF222426);

  @override
  void initState() {
    super.initState();
    _studio = widget.studio ?? dummyStudios[0];
    _selectedDateText = widget.initialDateText ?? 'Fri, 23 May';
    _selectedTime = widget.initialTime ?? '11:00';
    _selectedDuration = widget.initialDuration ?? 2;

    final defaultDurations = widget.availableDurations ?? [1, 2, 3];
    if (widget.initialDuration != null && !defaultDurations.contains(widget.initialDuration!)) {
      _durations = [...defaultDurations, widget.initialDuration!]..sort();
    } else {
      _durations = List.from(defaultDurations);
    }
  }

  // Calculate End Time (e.g., 11:00 + 2 hrs = 13:00)
  String _calculateEndTime(String start, int hours) {
    try {
      final parts = start.split(':');
      final startH = int.parse(parts[0]);
      final startM = parts[1];
      final endH = startH + hours;
      return '${endH.toString().padLeft(2, '0')}:$startM';
    } catch (_) {
      return '';
    }
  }

  // Pricing Calculation based on Duration
  int _calculateRentalPrice(int hours) {
    if (hours == 1) return 50000;
    if (hours == 2) return 90000;
    if (hours == 3) return 130000;
    return hours * 45000;
  }

  String _formatRupiah(int value) {
    String str = value.toString();
    String result = '';
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        result += '.';
      }
      result += str[i];
    }
    return 'Rp$result';
  }

  @override
  Widget build(BuildContext context) {
    final endTime = _calculateEndTime(_selectedTime, _selectedDuration);
    final rentalPrice = _calculateRentalPrice(_selectedDuration);
    const serviceFee = 5000;
    final totalPrice = rentalPrice + serviceFee;

    return Scaffold(
      backgroundColor: bgSurface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header (Back button + Subtitle + Title)
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
                              border: Border.all(
                                color: const Color(0xFFE5E2DA),
                              ),
                            ),
                            child: const Icon(
                              Icons.chevron_left,
                              color: darkInk,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'AVAILABILITY / JADWAL',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                                color: mutedGrey,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Choose your slot',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: darkInk,
                                letterSpacing: -0.6,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Studio Mini Card
                    _buildWhiteCard(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              _studio.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: 60,
                                    height: 60,
                                    color: const Color(0xFFE5E2DA),
                                    child: const Icon(
                                      Icons.image_outlined,
                                      color: mutedGrey,
                                    ),
                                  ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _studio.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: darkInk,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 14,
                                      color: mutedGrey,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      _studio.location,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: mutedGrey,
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

                    const SizedBox(height: 20),

                    // DATE Section
                    const Text(
                      'DATE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                        color: mutedGrey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildWhiteCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedDateText,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: darkInk,
                                ),
                              ),
                              const SizedBox(height: 3),
                              const Text(
                                'Available all day',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: greenBrand,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 20,
                            color: darkInk,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // START TIME Section
                    const Text(
                      'START TIME',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                        color: mutedGrey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        Row(
                          children: [
                            for (int i = 0; i < 3; i++) ...[
                              if (i > 0) const SizedBox(width: 10),
                              Expanded(
                                child: _buildTimeSlotButton(_timeSlots[i]),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            for (int i = 3; i < 6; i++) ...[
                              if (i > 3) const SizedBox(width: 10),
                              Expanded(
                                child: _buildTimeSlotButton(_timeSlots[i]),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // DURATION Section
                    const Text(
                      'DURATION',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                        color: mutedGrey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _durations.length <= 3
                        ? Row(
                            children: [
                              for (int i = 0; i < _durations.length; i++) ...[
                                if (i > 0) const SizedBox(width: 10),
                                Expanded(
                                  child: _buildDurationButton(_durations[i]),
                                ),
                              ],
                            ],
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: [
                                for (int i = 0; i < _durations.length; i++) ...[
                                  if (i > 0) const SizedBox(width: 10),
                                  SizedBox(
                                    width: 95,
                                    child: _buildDurationButton(_durations[i]),
                                  ),
                                ],
                              ],
                            ),
                          ),

                    const SizedBox(height: 18),

                    // Availability Alert Banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF5EE),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFF1B7D50),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 19,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'This slot is available',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF175C3B),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Operating hours & schedules checked',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF4D7D68),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Summary & Pricing Card
                    _buildWhiteCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$_selectedDateText · $_selectedTime–$endTime',
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF555955),
                                ),
                              ),
                              Text(
                                _formatRupiah(rentalPrice),
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: darkInk,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Service fee',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF555955),
                                ),
                              ),
                              Text(
                                _formatRupiah(serviceFee),
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: darkInk,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(
                            color: Color(0xFFF1EFEA),
                            height: 1,
                            thickness: 1,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500,
                                  color: darkInk,
                                ),
                              ),
                              Text(
                                _formatRupiah(totalPrice),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: darkInk,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom Continue Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingSummaryPage(
                          studioName: _studio.name,
                          studioLocation:
                              '${_studio.hostName} · ${_studio.location}',
                          studioImage: _studio.imageUrl,
                          dateText: 'Friday, 23 May 2025',
                          timeText: '$_selectedTime–$endTime',
                          durationText:
                              '$_selectedDuration ${_selectedDuration == 1 ? 'hour' : 'hours'}',
                          guestsText: _studio.people,
                          rentalPrice: rentalPrice,
                          serviceFee: serviceFee,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange,
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
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.chevron_right, size: 20, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable White Card with subtle border
  Widget _buildWhiteCard({required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder, width: 1),
      ),
      child: child,
    );
  }

  // Time Slot Button
  Widget _buildTimeSlotButton(Map<String, dynamic> slot) {
    final time = slot['time'] as String;
    final isAvailable = slot['available'] as bool;
    final isSelected = isAvailable && _selectedTime == time;

    Color bgColor;
    Color textColor;
    Border? border;
    TextDecoration? decoration;

    if (!isAvailable) {
      bgColor = const Color(0xFFEBE8E2);
      textColor = const Color(0xFFA5A39D);
      border = null;
      decoration = TextDecoration.lineThrough;
    } else if (isSelected) {
      bgColor = darkButtonBg;
      textColor = Colors.white;
      border = null;
      decoration = null;
    } else {
      bgColor = Colors.white;
      textColor = darkInk;
      border = Border.all(color: cardBorder, width: 1);
      decoration = null;
    }

    return InkWell(
      onTap: isAvailable
          ? () {
              setState(() {
                _selectedTime = time;
              });
            }
          : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: border,
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: textColor,
            decoration: decoration,
          ),
        ),
      ),
    );
  }

  // Duration Button
  Widget _buildDurationButton(int hours) {
    final isSelected = _selectedDuration == hours;
    final text = '$hours ${hours == 1 ? 'hour' : 'hours'}';

    return InkWell(
      onTap: () {
        setState(() {
          _selectedDuration = hours;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? darkButtonBg : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? null : Border.all(color: cardBorder, width: 1),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : darkInk,
          ),
        ),
      ),
    );
  }
}
