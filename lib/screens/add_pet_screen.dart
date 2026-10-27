import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/pet_data.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _historyController = TextEditingController();

  String _selectedCategory = 'สุนัข';
  String _selectedGender = 'ผู้ ♂';
  bool _isSpayed = false;
  String? _imagePath;

  final ImagePicker _picker = ImagePicker();

  final List<String> _categories = [
    'สุนัข',
    'แมว',
    'กระต่าย',
    'นก',
    'ปลา',
    'อื่นๆ',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _historyController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );
      if (picked != null) {
        setState(() {
          _imagePath = picked.path;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('แนบรูปภาพสัตว์เลี้ยงจากคลังภาพสำเร็จแล้ว'),
              backgroundColor: Color(0xFF673D17),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ไม่สามารถดึงรูปภาพได้: $e'),
            backgroundColor: Colors.red[700],
          ),
        );
      }
    }
  }

  void _showImagePickerModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF7EEDD),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'เลือกรูปภาพสัตว์เลี้ยง',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5C3A21),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF0E5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.photo_library_rounded, color: Color(0xFF673D17)),
                ),
                title: const Text('เลือกจากคลังรูปภาพ (Gallery)', style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEBF5FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt_rounded, color: Color(0xFF2B78C5)),
                ),
                title: const Text('ถ่ายภาพด้วยกล้อง (Camera)', style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.camera);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
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
          'เพิ่มสัตว์เลี้ยงใหม่',
          style: TextStyle(
            color: Color(0xFF5C3A21),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Pet Image Upload Box (Real Gallery/Camera Picker)
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _showImagePickerModal,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFFD8B896),
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: _imagePath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(22),
                                  child: Image.file(
                                    File(_imagePath!),
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo_rounded,
                                      size: 38,
                                      color: Color(0xFF8C735B),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      'ใส่รูปสัตว์เลี้ยง',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF8C735B),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: _showImagePickerModal,
                        icon: const Icon(Icons.photo_library_outlined, size: 18),
                        label: Text(
                          _imagePath != null ? 'เปลี่ยนรูปภาพสัตว์เลี้ยง' : 'เลือกรูปภาพจากคลังรูปภาพในเครื่อง',
                          style: const TextStyle(color: Color(0xFF673D17), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 2. Pet Category Selection
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.grid_view_rounded, color: Color(0xFF8C735B)),
                          SizedBox(width: 8),
                          Text(
                            'ประเภทสัตว์เลี้ยง:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5C3A21),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _categories.map((cat) {
                          final isSelected = _selectedCategory == cat;
                          return ChoiceChip(
                            label: Text(cat),
                            selected: isSelected,
                            selectedColor: const Color(0xFF673D17),
                            backgroundColor: const Color(0xFFFFF8F0),
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : const Color(0xFF5C3A21),
                              fontWeight: FontWeight.bold,
                            ),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _selectedCategory = cat;
                                });
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 3. Pet Name Input
                _buildInputField(
                  controller: _nameController,
                  label: 'ชื่อสัตว์เลี้ยง',
                  hint: 'เช่น โกโก้, มอมแมม',
                  icon: Icons.pets_rounded,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'กรุณากรอกชื่อสัตว์เลี้ยง';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // 4. Pet Breed Input
                _buildInputField(
                  controller: _breedController,
                  label: 'สายพันธุ์',
                  hint: 'เช่น โกลเด้น, เปอร์เซีย, ชิบะ',
                  icon: Icons.category_rounded,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'กรุณากรอกสายพันธุ์';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // 5. Gender Choice
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.wc_rounded, color: Color(0xFF8C735B)),
                          const SizedBox(width: 12),
                          const Text(
                            'เพศ:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5C3A21),
                            ),
                          ),
                          const Spacer(),
                          ChoiceChip(
                            label: const Text('ผู้ ♂'),
                            selected: _selectedGender == 'ผู้ ♂',
                            selectedColor: const Color(0xFF2B78C5),
                            labelStyle: TextStyle(
                              color: _selectedGender == 'ผู้ ♂'
                                  ? Colors.white
                                  : const Color(0xFF333333),
                              fontWeight: FontWeight.bold,
                            ),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _selectedGender = 'ผู้ ♂';
                                  _isSpayed = false;
                                });
                              }
                            },
                          ),
                          const SizedBox(width: 8),
                          ChoiceChip(
                            label: const Text('เมีย ♀'),
                            selected: _selectedGender == 'เมีย ♀',
                            selectedColor: const Color(0xFFE84A5F),
                            labelStyle: TextStyle(
                              color: _selectedGender == 'เมีย ♀'
                                  ? Colors.white
                                  : const Color(0xFF333333),
                              fontWeight: FontWeight.bold,
                            ),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _selectedGender = 'เมีย ♀';
                                });
                              }
                            },
                          ),
                        ],
                      ),

                      // Conditional Spayed Status Toggle
                      if (_selectedGender == 'เมีย ♀') ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF0F3),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFFFC0CB)),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.health_and_safety_rounded,
                                color: Color(0xFFE84A5F),
                                size: 22,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'การทำหมัน (สำหรับเพศเมีย)',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF5C3A21),
                                      ),
                                    ),
                                    Text(
                                      _isSpayed ? 'ทำหมันเรียบร้อยแล้ว' : 'ยังไม่ได้ทำหมัน',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _isSpayed
                                            ? const Color(0xFF2E7D32)
                                            : const Color(0xFFD84A38),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: _isSpayed,
                                activeTrackColor: const Color(0xFFE84A5F),
                                onChanged: (val) {
                                  setState(() {
                                    _isSpayed = val;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 6. Pet Age Input
                _buildInputField(
                  controller: _ageController,
                  label: 'อายุสัตว์เลี้ยง',
                  hint: 'เช่น 1 ปี 2 เดือน',
                  icon: Icons.cake_rounded,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'กรุณากรอกอายุสัตว์เลี้ยง';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // 7. Pet Weight Input
                _buildInputField(
                  controller: _weightController,
                  label: 'น้ำหนักสัตว์เลี้ยง',
                  hint: 'เช่น 8.5 กก.',
                  icon: Icons.monitor_weight_rounded,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'กรุณากรอกน้ำหนักสัตว์เลี้ยง';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // 8. Pet History Input
                _buildInputField(
                  controller: _historyController,
                  label: 'ประวัติของสัตว์เลี้ยง',
                  hint: 'ประวัติสุขภาพ, วัคซีนที่เคยฉีด, นิสัย, อาหารที่ชอบ',
                  icon: Icons.notes_rounded,
                  maxLines: 3,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'กรุณากรอกประวัติของสัตว์เลี้ยง';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),

                // Submit Button
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var weightText = _weightController.text.trim();
                        if (!weightText.contains('กก') && !weightText.contains('kg')) {
                          weightText = '$weightText กก.';
                        }

                        var historyText = _historyController.text.trim();
                        if (_selectedGender == 'เมีย ♀') {
                          final spayedText = _isSpayed ? 'ทำหมันแล้ว' : 'ยังไม่ทำหมัน';
                          historyText = 'สถานะทำหมัน: $spayedText | $historyText';
                        }

                        final newPet = PetItem(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: _nameController.text.trim(),
                          category: _selectedCategory,
                          breed: _breedController.text.trim(),
                          age: _ageController.text.trim(),
                          gender: _selectedGender,
                          isSpayed: _selectedGender == 'เมีย ♀' ? _isSpayed : false,
                          weight: weightText,
                          history: historyText,
                          imagePath: _imagePath,
                        );

                        setState(() {
                          PetDataStore.petsList.add(newPet);
                          PetDataStore.activePetIndex =
                              PetDataStore.petsList.length - 1;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'เพิ่มสัตว์เลี้ยง "${newPet.name}" (${newPet.category}) สำเร็จแล้ว!',
                            ),
                            backgroundColor: const Color(0xFF673D17),
                          ),
                        );

                        Navigator.of(context).pop(true);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF673D17),
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'บันทึกข้อมูลสัตว์เลี้ยง',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: const TextStyle(color: Color(0xFF333333), fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF5C3A21), fontWeight: FontWeight.bold),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFA09385), fontSize: 14),
          prefixIcon: Icon(icon, color: const Color(0xFF8C735B)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
