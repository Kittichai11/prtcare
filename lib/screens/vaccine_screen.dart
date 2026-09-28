import 'package:flutter/material.dart';
import '../models/pet_data.dart';

class VaccineScreen extends StatefulWidget {
  const VaccineScreen({super.key});

  @override
  State<VaccineScreen> createState() => _VaccineScreenState();
}

class _VaccineScreenState extends State<VaccineScreen> {
  final List<VaccineAppointmentItem> _appointments = PetDataStore.vaccineList;
  String _selectedFilter = 'ทั้งหมด'; // 'ทั้งหมด', 'วัคซีน', 'ตรวจสุขภาพ'

  List<VaccineAppointmentItem> get _filteredAppointments {
    if (_selectedFilter == 'ทั้งหมด') {
      return _appointments;
    }
    return _appointments.where((a) => a.type == _selectedFilter).toList();
  }

  void _addOrEditAppointment({VaccineAppointmentItem? editItem, int? index}) {
    final titleController =
        TextEditingController(text: editItem?.title ?? '');
    String selectedType = editItem?.type ?? 'วัคซีน';
    DateTime selectedDate = DateTime.now().add(const Duration(days: 7));
    TimeOfDay selectedReminderTime = const TimeOfDay(hour: 9, minute: 0);

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
            final dateStr =
                '${selectedDate.day} ส.ค. ${selectedDate.year + 543}';
            final reminderStr =
                '${selectedReminderTime.hour.toString().padLeft(2, '0')}:${selectedReminderTime.minute.toString().padLeft(2, '0')} น.';

            return Padding(
              padding: EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    editItem == null ? 'เพิ่มวันนัดสัตวแพทย์ / วัคซีน' : 'แก้ไขวันนัด',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C3A21),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Segmented type choice
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(
                        value: 'วัคซีน',
                        label: Text('ฉีดวัคซีน'),
                        icon: Icon(Icons.vaccines_rounded),
                      ),
                      ButtonSegment(
                        value: 'ตรวจสุขภาพ',
                        label: Text('ตรวจสุขภาพ'),
                        icon: Icon(Icons.medical_services_rounded),
                      ),
                    ],
                    selected: {selectedType},
                    onSelectionChanged: (newSelection) {
                      setBottomSheetState(() {
                        selectedType = newSelection.first;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Title Input
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'ชื่อหัวข้อนัดหมาย (เช่น วัคซีนรวม, ตรวจสุขภาพ)',
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

                  // Date Picker Selector
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setBottomSheetState(() {
                          selectedDate = picked;
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
                            'วันที่หมอนัด:',
                            style: TextStyle(fontSize: 15, color: Color(0xFF5C3A21)),
                          ),
                          Row(
                            children: [
                              Text(
                                dateStr,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF673D17),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.calendar_month_rounded, color: Color(0xFF673D17)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Reminder Time Picker
                  InkWell(
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: selectedReminderTime,
                      );
                      if (time != null) {
                        setBottomSheetState(() {
                          selectedReminderTime = time;
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
                            'ตั้งเวลาแจ้งเตือนในวันนัด:',
                            style: TextStyle(fontSize: 15, color: Color(0xFF5C3A21)),
                          ),
                          Row(
                            children: [
                              Text(
                                reminderStr,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF673D17),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.notifications_active_rounded, color: Color(0xFF673D17)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Submit Button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        final title = titleController.text.trim().isEmpty
                            ? selectedType
                            : titleController.text.trim();
                        final diffDays =
                            selectedDate.difference(DateTime.now()).inDays + 1;

                        setState(() {
                          if (editItem != null && index != null) {
                            _appointments[index] = VaccineAppointmentItem(
                              id: editItem.id,
                              title: title,
                              date: dateStr,
                              daysLeft: diffDays > 0 ? diffDays : 0,
                              reminderTime: reminderStr,
                              type: selectedType,
                            );
                          } else {
                            _appointments.add(
                              VaccineAppointmentItem(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                title: title,
                                date: dateStr,
                                daysLeft: diffDays > 0 ? diffDays : 0,
                                reminderTime: reminderStr,
                                type: selectedType,
                              ),
                            );
                          }
                        });
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('บันทึกการตั้งค่าวันนัดและเวลาแจ้งเตือนเรียบร้อยแล้ว'),
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
                        'บันทึกวันนัดหมาย',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _deleteAppointment(int index) {
    final deleted = _filteredAppointments[index];
    setState(() {
      _appointments.removeWhere((a) => a.id == deleted.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('ลบนัดหมาย "${deleted.title}" แล้ว'),
        backgroundColor: Colors.red[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = _filteredAppointments;

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
          'นัดพบสัตวแพทย์ & วัคซีน',
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
                        Icons.event_available_rounded,
                        color: Color(0xFFD84A38),
                        size: 36,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'กำหนดการนัดหมายสัตว์เลี้ยง',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A2810),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'รวมวันนัดหมอตะวันและฉีดวัคซีน พร้อมการแจ้งเตือนเวลา',
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
              const SizedBox(height: 16),

              // Filter Chips
              Row(
                children: [
                  _buildFilterChip('ทั้งหมด'),
                  const SizedBox(width: 8),
                  _buildFilterChip('วัคซีน'),
                  const SizedBox(width: 8),
                  _buildFilterChip('ตรวจสุขภาพ'),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'รายการนัดหมาย (${list.length})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C3A21),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _addOrEditAppointment(),
                    icon: const Icon(Icons.add_circle_rounded, color: Color(0xFF673D17), size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Appointment List
              Expanded(
                child: list.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.event_available_outlined, size: 64, color: Colors.brown[300]),
                            const SizedBox(height: 12),
                            const Text(
                              'ยังไม่มีนัดหมายในหมวดนี้\nกดปุ่ม "+" เพื่อเพิ่มวันนัดใหม่',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: Color(0xFF8C735B)),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final item = list[index];
                          final isVaccine = item.type == 'วัคซีน';

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
                                    color: isVaccine
                                        ? const Color(0xFFFFF0F0)
                                        : const Color(0xFFEBF5FF),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    isVaccine
                                        ? Icons.vaccines_rounded
                                        : Icons.calendar_month_rounded,
                                    color: isVaccine
                                        ? const Color(0xFFD84A38)
                                        : const Color(0xFF2B78C5),
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
                                        'อีก ${item.daysLeft} วัน  •  ${item.date}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF673D17),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.notifications_active_outlined,
                                            size: 14,
                                            color: Color(0xFF8C735B),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'แจ้งเตือนเวลา ${item.reminderTime}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF8C735B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  icon: const Icon(Icons.more_vert_rounded, color: Color(0xFF8C735B)),
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      _addOrEditAppointment(editItem: item, index: index);
                                    } else if (value == 'delete') {
                                      _deleteAppointment(index);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit_outlined, color: Color(0xFF673D17)),
                                          SizedBox(width: 8),
                                          Text('แก้ไขการตั้งค่าวันและเวลา'),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete_outline, color: Colors.red),
                                          SizedBox(width: 8),
                                          Text('ลบนัดหมายนี้', style: TextStyle(color: Colors.red)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              // Bottom Button
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () => _addOrEditAppointment(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673D17),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  icon: const Icon(Icons.add_alarm_rounded, size: 22),
                  label: const Text(
                    'ตั้งค่าแจ้งเตือนวันนัดหมายเพิ่ม',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: const Color(0xFF673D17),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : const Color(0xFF5C3A21),
        fontWeight: FontWeight.bold,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFilter = label;
          });
        }
      },
    );
  }
}
