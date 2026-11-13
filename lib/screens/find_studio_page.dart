import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'search_result_page.dart';

// ============================================================================
// FORM KEBUTUHAN / FIND ME A STUDIO
// Dikerjakan oleh: Senna Almalia Syafila (162024019)
// ============================================================================
class FindStudioPage extends StatefulWidget {
  const FindStudioPage({super.key});

  @override
  State<FindStudioPage> createState() => _FindStudioPageState();
}

class _FindStudioPageState extends State<FindStudioPage> {
  int people = 4;
  int selectedCooling = 0; // 0: AC, 1: Fan, 2: Any
  int durationHours = 2;
  RangeValues budget = const RangeValues(50000, 200000);
  DateTime selectedDate = DateTime(2026, 5, 23);
  TimeOfDay selectedTime = const TimeOfDay(hour: 11, minute: 0);

  final TextEditingController peopleController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  final Color orange = const Color(0xFFFF6B4A);
  final Color border = const Color(0xFFE0DCD5);

  @override
  void dispose() {
    peopleController.dispose();
    durationController.dispose();
    super.dispose();
  }

  String _rupiah(double value) {
    String angka = value.round().toString();
    String hasil = '';
    for (int i = 0; i < angka.length; i++) {
      if (i > 0 && (angka.length - i) % 3 == 0) {
        hasil += '.';
      }
      hasil += angka[i];
    }
    return 'Rp$hasil';
  }

  String _formatDate(DateTime d) {
    const bulan = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${d.day} ${bulan[d.month - 1]}';
  }

  String _formatTime(TimeOfDay t) {
    String jam = t.hour.toString().padLeft(2, '0');
    String menit = t.minute.toString().padLeft(2, '0');
    return '$jam:$menit';
  }

  Future<void> _pickDate() async {
    DateTime? hasil = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (hasil != null) {
      setState(() {
        selectedDate = hasil;
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? hasil = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (hasil != null) {
      setState(() {
        selectedTime = hasil;
      });
    }
  }

  void _editPeople() {
    peopleController.text = people.toString();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Number of people'),
          content: TextField(
            controller: peopleController,
            autofocus: true,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Masukkan angka',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                int? angka = int.tryParse(peopleController.text);
                if (angka != null && angka >= 1) {
                  setState(() {
                    people = angka;
                  });
                }
                Navigator.pop(dialogContext);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _editDuration() {
    durationController.text = durationHours.toString();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Duration (hours)'),
          content: TextField(
            controller: durationController,
            autofocus: true,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Masukkan angka',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                int? angka = int.tryParse(durationController.text);
                if (angka != null && angka >= 1) {
                  setState(() {
                    durationHours = angka;
                  });
                }
                Navigator.pop(dialogContext);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          letterSpacing: 1,
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: child,
    );
  }

  Widget _budgetBox(String label, double value) {
    return Expanded(
      child: _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.black54),
            ),
            const SizedBox(height: 4),
            Text(
              _rupiah(value),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan tombol kembali
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: border),
                      ),
                      child: const Icon(Icons.chevron_left),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STUDIO MATCH',
                        style: TextStyle(
                          fontSize: 10,
                          letterSpacing: 1,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Find me a studio',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Tell us what you need and we\'ll show only studios that fit your session.',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),

              _label('LOCATION'),
              _card(
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: orange.withAlpha(38),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.location_on_outlined, color: orange),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Area or city',
                            style: TextStyle(fontSize: 10, color: Colors.black54),
                          ),
                          Text(
                            'Kemang, Jakarta',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),

              Row(
                children: [
                  Expanded(child: _label('DATE')),
                  const SizedBox(width: 12),
                  Expanded(child: _label('START TIME')),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _pickDate,
                      child: _card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Session date',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  _formatDate(selectedDate),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(Icons.calendar_today_outlined, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: _pickTime,
                      child: _card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Preferred time',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  _formatTime(selectedTime),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(Icons.access_time, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              _label('NUMBER OF PEOPLE'),
              _card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (people > 1) {
                            people--;
                          }
                        });
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0EDE8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.remove, size: 18),
                      ),
                    ),
                    GestureDetector(
                      onTap: _editPeople,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '$people people',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.edit, size: 14),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          people++;
                        });
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0EDE8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add, size: 18),
                      ),
                    ),
                  ],
                ),
              ),

              _label('COOLING TYPE'),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCooling = 0;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selectedCooling == 0
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: selectedCooling == 0
                                ? Colors.black
                                : border,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Air conditioning',
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedCooling == 0
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCooling = 1;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selectedCooling == 1
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: selectedCooling == 1
                                ? Colors.black
                                : border,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Fan',
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedCooling == 1
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCooling = 2;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selectedCooling == 2
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: selectedCooling == 2
                                ? Colors.black
                                : border,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Any',
                            style: TextStyle(
                              fontSize: 12,
                              color: selectedCooling == 2
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              _label('DURATION'),
              _card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (durationHours > 1) {
                            durationHours--;
                          }
                        });
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0EDE8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.remove, size: 18),
                      ),
                    ),
                    GestureDetector(
                      onTap: _editDuration,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Text(
                              durationHours == 1
                                  ? '1 hour'
                                  : '$durationHours hours',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.edit, size: 14),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          durationHours++;
                        });
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0EDE8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add, size: 18),
                      ),
                    ),
                  ],
                ),
              ),

              _label('BUDGET'),
              Row(
                children: [
                  _budgetBox('Minimum', budget.start),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('-'),
                  ),
                  _budgetBox('Maximum', budget.end),
                ],
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: orange,
                  inactiveTrackColor: border,
                  thumbColor: orange,
                  overlayColor: orange.withAlpha(38),
                ),
                child: RangeSlider(
                  values: budget,
                  min: 0,
                  max: 500000,
                  divisions: 50,
                  onChanged: (RangeValues newValues) {
                    setState(() {
                      budget = newValues;
                    });
                  },
                ),
              ),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F4EA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check, color: Colors.green, size: 20),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '12 studios match',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Available for your selected date and time',
                          style: TextStyle(fontSize: 10, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultPage(
                          location: 'Kemang',
                          date: _formatDate(selectedDate),
                          time: '${_formatTime(selectedTime)} - $durationHours hr',
                          people: '$people people',
                          cooling: selectedCooling == 0
                              ? 'Air conditioning'
                              : (selectedCooling == 1 ? 'Fan' : 'Any'),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Show 12 studios',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

