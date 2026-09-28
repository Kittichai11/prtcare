import 'package:flutter/material.dart';
import '../models/pet_data.dart';

class DogWalkingScreen extends StatefulWidget {
  const DogWalkingScreen({super.key});

  @override
  State<DogWalkingScreen> createState() => _DogWalkingScreenState();
}

class _DogWalkingScreenState extends State<DogWalkingScreen> {
  final List<DogWalkingItem> _walkingList = PetDataStore.dogWalkingList;

  void _addWalkingSchedule() {
    final titleController = TextEditingController();
    String selectedActivity = 'เดินเล่น';
    String selectedDuration = '30 นาที';
    String selectedDays = 'ทุกวัน';
    TimeOfDay selectedTime = const TimeOfDay(hour: 17, minute: 0);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF7EEDD),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setBottomSheetState) {
            final timeStr =
                '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')} น.';

            return Padding(
              padding: EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'ตั้งวันและเวลา Dog Walking',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5C3A21),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Activity Type Choice
                    const Row(
                      children: [
                        Icon(Icons.fitness_center_rounded, color: Color(0xFF8C735B)),
                        SizedBox(width: 8),
                        Text(
                          'ประเภทกิจกรรม:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5C3A21),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<String>(
                      segments: const <ButtonSegment<String>>[
                        ButtonSegment<String>(
                          value: 'เดินเล่น',
                          label: Text('เดินเล่น'),
                          icon: Icon(Icons.directions_walk_rounded),
                        ),
                        ButtonSegment<String>(
                          value: 'วิ่งออกกำลังกาย',
                          label: Text('วิ่งออกกำลังกาย'),
                          icon: Icon(Icons.directions_run_rounded),
                        ),
                      ],
                      selected: {selectedActivity},
                      onSelectionChanged: (newSelection) {
                        setBottomSheetState(() {
                          selectedActivity = newSelection.first;
                        });
                      },
                    ),
                    const SizedBox(height: 14),

                    // Title Input
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'หัวข้อย่อ (เช่น พาน้องเดินเล่นยามเย็น)',
                        labelStyle: const TextStyle(color: Color(0xFF8C735B)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Time Picker Selector
                    InkWell(
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (time != null) {
                          setBottomSheetState(() {
                            selectedTime = time;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'ตั้งเวลาออกไปเดินเล่น:',
                              style: TextStyle(fontSize: 15, color: Color(0xFF5C3A21)),
                            ),
                            Row(
                              children: [
                                Text(
                                  timeStr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF673D17),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.access_time_rounded, color: Color(0xFF673D17)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Schedule Days Dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'ความถี่:',
                            style: TextStyle(fontSize: 15, color: Color(0xFF5C3A21)),
                          ),
                          DropdownButton<String>(
                            value: selectedDays,
                            underline: const SizedBox(),
                            items: const [
                              DropdownMenuItem(value: 'ทุกวัน', child: Text('ทุกวัน')),
                              DropdownMenuItem(value: 'ทุกวันเย็น', child: Text('ทุกวันเย็น')),
                              DropdownMenuItem(value: 'เสาร์-อาทิตย์', child: Text('เสาร์-อาทิตย์')),
                              DropdownMenuItem(value: 'เฉพาะวันหยุด', child: Text('เฉพาะวันหยุด')),
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setBottomSheetState(() {
                                  selectedDays = val;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Duration Selector
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'ระยะเวลา:',
                            style: TextStyle(fontSize: 15, color: Color(0xFF5C3A21)),
                          ),
                          DropdownButton<String>(
                            value: selectedDuration,
                            underline: const SizedBox(),
                            items: const [
                              DropdownMenuItem(value: '15 นาที', child: Text('15 นาที')),
                              DropdownMenuItem(value: '30 นาที', child: Text('30 นาที')),
                              DropdownMenuItem(value: '45 นาที', child: Text('45 นาที')),
                              DropdownMenuItem(value: '1 ชั่วโมง', child: Text('1 ชั่วโมง')),
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setBottomSheetState(() {
                                  selectedDuration = val;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          final title = titleController.text.trim().isEmpty
                              ? 'พาสัตว์เลี้ยงออกไป$selectedActivity'
                              : titleController.text.trim();

                          setState(() {
                            _walkingList.add(
                              DogWalkingItem(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                title: title,
                                time: timeStr,
                                daysOrDate: selectedDays,
                                activityType: selectedActivity,
                                duration: selectedDuration,
                              ),
                            );
                          });

                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('บันทึกกำหนดการ Dog Walking เรียบร้อยแล้ว'),
                              backgroundColor: Color(0xFF673D17),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF673D17),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'บันทึกวันและเวลาเดินเล่น',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _deleteWalkingItem(int index) {
    final deleted = _walkingList[index];
    setState(() {
      _walkingList.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('ลบรายการ "${deleted.title}" แล้ว'),
        backgroundColor: Colors.red[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EEDD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF5C3A21)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Dog Walking & ออกกำลังกาย',
          style: TextStyle(
            color: Color(0xFF5C3A21),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Banner Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFD8B896),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.directions_run_rounded,
                        color: Color(0xFF2B78C5),
                        size: 36,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'กิจกรรมเดินเล่นและออกกำลังกาย',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A2810),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'ตั้งค่าวันและเวลาสำหรับพาสัตว์เลี้ยงออกไปเดินเล่นนอกบ้าน',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6B4D33),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'กำหนดการเดินเล่น',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C3A21),
                    ),
                  ),
                  IconButton(
                    onPressed: _addWalkingSchedule,
                    icon: const Icon(Icons.add_circle_rounded, color: Color(0xFF673D17), size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Walking List
              Expanded(
                child: _walkingList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.directions_walk_rounded, size: 64, color: Colors.brown[300]),
                            const SizedBox(height: 12),
                            const Text(
                              'ยังไม่มีกำหนดการ Dog Walking\nกดปุ่มด้านล่างเพื่อตั้งวันและเวลาเดินเล่น',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: Color(0xFF8C735B)),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _walkingList.length,
                        itemBuilder: (context, index) {
                          final item = _walkingList[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEBF5FF),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    Icons.directions_run_rounded,
                                    color: Color(0xFF2B78C5),
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF333333),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'เวลา ${item.time}  •  ${item.daysOrDate}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF673D17),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'กิจกรรม: ${item.activityType} (${item.duration})',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF8C735B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.redAccent,
                                    size: 24,
                                  ),
                                  onPressed: () => _deleteWalkingItem(index),
                                  tooltip: 'ลบรายการนี้',
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              // Bottom Action Button
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _addWalkingSchedule,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673D17),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  icon: const Icon(Icons.directions_run_rounded, size: 22),
                  label: const Text(
                    'ตั้งวันและเวลา พาสัตว์เลี้ยงออกไปเดินเล่น',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
