import 'package:flutter/material.dart';
import '../models/pet_data.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  final List<MedicalRecordItem> _records = PetDataStore.recordList;

  void _addOrEditRecord({MedicalRecordItem? record, int? index}) {
    final titleController = TextEditingController(text: record?.title ?? '');
    final dateController = TextEditingController(
      text: record?.date ?? '${DateTime.now().day} ส.ค. ${DateTime.now().year + 543}',
    );
    final clinicController = TextEditingController(text: record?.clinic ?? '');
    final detailsController = TextEditingController(text: record?.details ?? '');
    final doctorController = TextEditingController(text: record?.doctor ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF7EEDD),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
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
                Text(
                  record == null ? 'เพิ่มบันทึกการรักษา' : 'แก้ไขบันทึกการรักษา',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5C3A21),
                  ),
                ),
                const SizedBox(height: 18),

                // Title
                _buildModalTextField(
                  controller: titleController,
                  label: 'หัวข้อการรักษา / อาการป่วย',
                  icon: Icons.medical_services_outlined,
                ),
                const SizedBox(height: 12),

                // Date
                _buildModalTextField(
                  controller: dateController,
                  label: 'วันที่รับการรักษา (เช่น 15 ส.ค. 2026)',
                  icon: Icons.calendar_today_outlined,
                ),
                const SizedBox(height: 12),

                // Clinic
                _buildModalTextField(
                  controller: clinicController,
                  label: 'โรงพยาบาลสัตว์ / คลินิก',
                  icon: Icons.local_hospital_outlined,
                ),
                const SizedBox(height: 12),

                // Doctor Name
                _buildModalTextField(
                  controller: doctorController,
                  label: 'สัตวแพทย์ผู้ดูแล',
                  icon: Icons.badge_outlined,
                ),
                const SizedBox(height: 12),

                // Details
                _buildModalTextField(
                  controller: detailsController,
                  label: 'รายละเอียดการรักษา / ยาที่ได้รับ / น้ำหนัก',
                  icon: Icons.notes_outlined,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),

                // Submit Button
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (titleController.text.trim().isEmpty) {
                        titleController.text = 'ตรวจรักษาทั่วไป';
                      }
                      setState(() {
                        final newItem = MedicalRecordItem(
                          id: record?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                          title: titleController.text.trim(),
                          date: dateController.text.trim(),
                          clinic: clinicController.text.trim().isEmpty ? 'คลินิกสัตว์เลี้ยง' : clinicController.text.trim(),
                          details: detailsController.text.trim(),
                          doctor: doctorController.text.trim(),
                        );

                        if (record != null && index != null) {
                          _records[index] = newItem;
                        } else {
                          _records.insert(0, newItem);
                        }
                      });

                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(record == null
                              ? 'เพิ่มประวัติการรักษาเรียบร้อยแล้ว'
                              : 'อัปเดตประวัติการรักษาเรียบร้อยแล้ว'),
                          backgroundColor: const Color(0xFF673D17),
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
                    child: Text(
                      record == null ? 'บันทึกข้อมูลการรักษา' : 'บันทึกการแก้ไข',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF8C735B)),
        prefixIcon: Icon(icon, color: const Color(0xFF673D17)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _deleteRecord(int index) {
    final deleted = _records[index];
    setState(() {
      _records.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('ลบบันทึก "${deleted.title}" แล้ว'),
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
        title: const Text(
          'บันทึกข้อมูลการรักษา',
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
              // Header Card
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
                        Icons.assignment_turned_in_rounded,
                        color: Color(0xFF673D17),
                        size: 36,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ประวัติสุขภาพและการรักษา',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A2810),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'รวบรวมประวัติการพบแพทย์และประวัติวัคซีน',
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
                    'รายการบันทึกการรักษา',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C3A21),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _addOrEditRecord(),
                    icon: const Icon(Icons.add_circle_rounded, color: Color(0xFF673D17), size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Records List
              Expanded(
                child: _records.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.assignment_late_outlined, size: 64, color: Colors.brown[300]),
                            const SizedBox(height: 12),
                            const Text(
                              'ยังไม่มีประวัติการรักษา\nกดปุ่ม "+" เพื่อบันทึกประวัติสุขภาพใหม่',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: Color(0xFF8C735B)),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _records.length,
                        itemBuilder: (context, index) {
                          final item = _records[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.all(18),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.title,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF333333),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit_note_rounded, color: Color(0xFF673D17), size: 26),
                                          onPressed: () => _addOrEditRecord(record: item, index: index),
                                          tooltip: 'แก้ไขบันทึก',
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 22),
                                          onPressed: () => _deleteRecord(index),
                                          tooltip: 'ลบบันทึก',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(color: Color(0xFFE8DCCB)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today_rounded, size: 16, color: Color(0xFF8C735B)),
                                    const SizedBox(width: 6),
                                    Text(
                                      'วันที่: ${item.date}',
                                      style: const TextStyle(fontSize: 14, color: Color(0xFF5C3A21), fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF8C735B)),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        'สถานพยาบาล: ${item.clinic}',
                                        style: const TextStyle(fontSize: 14, color: Color(0xFF5C3A21)),
                                      ),
                                    ),
                                  ],
                                ),
                                if (item.doctor.isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.badge_outlined, size: 16, color: Color(0xFF8C735B)),
                                      const SizedBox(width: 6),
                                      Text(
                                        'สัตวแพทย์: ${item.doctor}',
                                        style: const TextStyle(fontSize: 14, color: Color(0xFF5C3A21)),
                                      ),
                                    ],
                                  ),
                                ],
                                if (item.details.isNotEmpty) ...[
                                  const SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF9F2),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: const Color(0xFFE8DCCB)),
                                    ),
                                    child: Text(
                                      item.details,
                                      style: const TextStyle(fontSize: 14, color: Color(0xFF4A3525)),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
              ),

              // Add New Record Button
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () => _addOrEditRecord(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673D17),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  icon: const Icon(Icons.add, size: 24),
                  label: const Text(
                    'เพิ่มข้อมูลการรักษา',
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
}
