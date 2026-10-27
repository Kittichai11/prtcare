import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/pet_data.dart';
import 'login.dart';
import 'add_pet_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final OwnerProfile _profile = PetDataStore.currentProfile;
  final ImagePicker _picker = ImagePicker();

  bool _isOwnerNameVisible = true;
  bool _isOwnerEmailVisible = true;
  bool _isOwnerPhoneVisible = true;
  bool _isMasterOwnerVisible = true;

  final Map<String, bool> _petVisibilityMap = {};

  bool _isPetVisible(String petId) {
    return _petVisibilityMap[petId] ?? true;
  }

  void _togglePetVisibility(String petId) {
    setState(() {
      _petVisibilityMap[petId] = !_isPetVisible(petId);
    });
  }

  void _toggleMasterOwnerVisibility() {
    setState(() {
      _isMasterOwnerVisible = !_isMasterOwnerVisible;
      _isOwnerNameVisible = _isMasterOwnerVisible;
      _isOwnerEmailVisible = _isMasterOwnerVisible;
      _isOwnerPhoneVisible = _isMasterOwnerVisible;
    });
  }

  String _maskValue(String text, bool isVisible) {
    if (isVisible) return text;
    if (text.trim().isEmpty) return '••••';

    if (text.contains('@')) {
      final parts = text.split('@');
      final user = parts[0];
      final domain = parts[1];
      if (user.length > 2) {
        return '${user.substring(0, 1)}••••@$domain';
      }
      return '••••@$domain';
    }

    if (RegExp(r'^[0-9\-\s]+$').hasMatch(text) && text.length >= 8) {
      return '${text.substring(0, 3)}-***-****';
    }

    if (text.startsWith('คุณ ') && text.length > 5) {
      return 'คุณ ${text.substring(4, 5)}••••';
    }

    if (text.length <= 4) {
      return '••••';
    }

    return '${text.substring(0, 1)}••••••••';
  }

  Future<void> _pickOwnerImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (picked != null) {
        setState(() {
          _profile.imagePath = picked.path;
          PetDataStore.currentUser.profileImagePath = picked.path;
        });
        PetDataStore.saveToStorage();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('อัปเดตรูปภาพโปรไฟล์เรียบร้อยแล้ว'),
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
                'เปลี่ยนรูปภาพโปรไฟล์เจ้าของ ID',
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
                  _pickOwnerImage(ImageSource.gallery);
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
                  _pickOwnerImage(ImageSource.camera);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _editProfile() {
    final nameController = TextEditingController(text: _profile.name);
    final emailController = TextEditingController(text: _profile.email);
    final phoneController = TextEditingController(text: _profile.phone);

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
                const Text(
                  'แก้ไขข้อมูลโปรไฟล์เจ้าของ ID',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5C3A21),
                  ),
                ),
                const SizedBox(height: 18),

                _buildEditTextField(
                  controller: nameController,
                  label: 'ชื่อเจ้าของ ID',
                  icon: Icons.person_outline_rounded,
                ),
                const SizedBox(height: 12),

                _buildEditTextField(
                  controller: emailController,
                  label: 'อีเมล',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),

                _buildEditTextField(
                  controller: phoneController,
                  label: 'เบอร์โทรศัพท์',
                  icon: Icons.phone_android_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 24),

                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _profile.name = nameController.text.trim();
                        _profile.email = emailController.text.trim();
                        _profile.phone = phoneController.text.trim();

                        PetDataStore.currentUser.fullName = _profile.name;
                        PetDataStore.currentUser.email = _profile.email;
                        PetDataStore.currentUser.phone = _profile.phone;
                      });

                      PetDataStore.saveToStorage();

                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('อัปเดตข้อมูลโปรไฟล์เรียบร้อยแล้ว'),
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
                      'บันทึกข้อมูลโปรไฟล์',
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
  }

  Widget _buildEditTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EEDD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'โปรไฟล์เจ้าของ ID',
          style: TextStyle(
            color: Color(0xFF5C3A21),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF5C3A21)),
            onPressed: _editProfile,
            tooltip: 'แก้ไขโปรไฟล์',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // User Avatar Card
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: _showImagePickerModal,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFF673D17),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: _profile.imagePath != null
                                ? ClipOval(
                                    child: buildAppImage(
                                      imagePath: _profile.imagePath!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(
                                    Icons.person_rounded,
                                    size: 64,
                                    color: Color(0xFFF7EEDD),
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _showImagePickerModal,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFFD8B896),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                size: 18,
                                color: Color(0xFF4A2810),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      _maskValue('คุณ ${_profile.name}', _isOwnerNameVisible),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _maskValue(_profile.email, _isOwnerEmailVisible),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8C735B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Owner Info Card with Master & Individual Eye Toggle Buttons
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
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
                        const Text(
                          'ข้อมูลเจ้าของ ID',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5C3A21),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isMasterOwnerVisible
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            color: const Color(0xFF673D17),
                          ),
                          onPressed: _toggleMasterOwnerVisibility,
                          tooltip: _isMasterOwnerVisible ? 'เซนเซอร์ข้อมูลทั้งหมด' : 'แสดงข้อมูลทั้งหมด',
                        ),
                      ],
                    ),
                    const Divider(color: Color(0xFFE8DCCB), height: 10),
                    const SizedBox(height: 10),

                    // Owner Name Row
                    _buildToggleableInfoRow(
                      icon: Icons.person_outline_rounded,
                      label: 'ชื่อเจ้าของ',
                      value: 'คุณ ${_profile.name}',
                      isVisible: _isOwnerNameVisible,
                      onToggle: () {
                        setState(() {
                          _isOwnerNameVisible = !_isOwnerNameVisible;
                        });
                      },
                    ),

                    // Email Row
                    _buildToggleableInfoRow(
                      icon: Icons.email_outlined,
                      label: 'อีเมล',
                      value: _profile.email,
                      isVisible: _isOwnerEmailVisible,
                      onToggle: () {
                        setState(() {
                          _isOwnerEmailVisible = !_isOwnerEmailVisible;
                        });
                      },
                    ),

                    // Phone Row
                    _buildToggleableInfoRow(
                      icon: Icons.phone_android_outlined,
                      label: 'เบอร์โทรศัพท์',
                      value: _profile.phone,
                      isVisible: _isOwnerPhoneVisible,
                      onToggle: () {
                        setState(() {
                          _isOwnerPhoneVisible = !_isOwnerPhoneVisible;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Pets Header & List
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ข้อมูลสัตว์เลี้ยงทั้งหมด',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C3A21),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final res = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddPetScreen()),
                      );
                      if (res == true) {
                        setState(() {});
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF673D17),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('เพิ่มสัตว์เลี้ยง', style: TextStyle(fontSize: 13)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Pet List Cards
              ...PetDataStore.petsList.map((pet) {
                final isPetVisible = _isPetVisible(pet.id);

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
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
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF0E5),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: pet.imagePath != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: buildAppImage(
                                      imagePath: pet.imagePath!,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(
                                    Icons.pets_rounded,
                                    color: Color(0xFF673D17),
                                    size: 28,
                                  ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      _maskValue(pet.name, isPetVisible),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      pet.gender,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: pet.gender.contains('ผู้')
                                            ? const Color(0xFF2B78C5)
                                            : const Color(0xFFE84A5F),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'ประเภท: ${_maskValue(pet.category, isPetVisible)}  •  สายพันธุ์: ${_maskValue(pet.breed, isPetVisible)}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF7A6551),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'อายุ: ${_maskValue(pet.age, isPetVisible)}  •  น้ำหนัก: ${_maskValue(pet.weight, isPetVisible)}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF7A6551),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Eye Toggle Button
                          IconButton(
                            icon: Icon(
                              isPetVisible
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              color: const Color(0xFF673D17),
                            ),
                            onPressed: () => _togglePetVisibility(pet.id),
                            tooltip: isPetVisible ? 'เซนเซอร์ข้อมูลสัตว์เลี้ยง' : 'แสดงข้อมูลสัตว์เลี้ยง',
                          ),
                        ],
                      ),
                      if (pet.history.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF9F2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFE8DCCB)),
                          ),
                          child: Text(
                            'ประวัติ: ${_maskValue(pet.history, isPetVisible)}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF4A3525),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),

              // Edit Owner Profile Button
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _editProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673D17),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  icon: const Icon(Icons.edit_rounded, size: 20),
                  label: const Text(
                    'แก้ไขข้อมูลโปรไฟล์เจ้าของ ID',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Logout Button
              SizedBox(
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                    PetDataStore.logout();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red[700],
                    side: const BorderSide(color: Colors.redAccent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  icon: const Icon(Icons.logout_rounded, size: 20),
                  label: const Text(
                    'ออกจากระบบ',
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

  Widget _buildToggleableInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required bool isVisible,
    required VoidCallback onToggle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF8C735B), size: 22),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 14, color: Color(0xFF7A6551)),
          ),
          Expanded(
            child: Text(
              _maskValue(value, isVisible),
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ),
          const SizedBox(width: 6),
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                isVisible
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: isVisible ? const Color(0xFF673D17) : const Color(0xFFA09385),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
