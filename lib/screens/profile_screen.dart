import 'package:flutter/material.dart';
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

                // Owner Name
                _buildEditTextField(
                  controller: nameController,
                  label: 'ชื่อเจ้าของ ID',
                  icon: Icons.person_outline_rounded,
                ),
                const SizedBox(height: 12),

                // Email
                _buildEditTextField(
                  controller: emailController,
                  label: 'อีเมล',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),

                // Phone
                _buildEditTextField(
                  controller: phoneController,
                  label: 'เบอร์โทรศัพท์',
                  icon: Icons.phone_android_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _profile.name = nameController.text.trim();
                        _profile.email = emailController.text.trim();
                        _profile.phone = phoneController.text.trim();
                      });

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
                        Container(
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
                          child: const Icon(
                            Icons.person_rounded,
                            size: 64,
                            color: Color(0xFFF7EEDD),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _editProfile,
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
                      'คุณ ${_profile.name}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _profile.email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8C735B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Owner Info Card
              _buildInfoSection(
                title: 'ข้อมูลเจ้าของ ID',
                items: [
                  _InfoRow(icon: Icons.person_outline_rounded, label: 'ชื่อเจ้าของ', value: 'คุณ ${_profile.name}'),
                  _InfoRow(icon: Icons.email_outlined, label: 'อีเมล', value: _profile.email),
                  _InfoRow(icon: Icons.phone_android_outlined, label: 'เบอร์โทรศัพท์', value: _profile.phone),
                ],
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
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF0E5),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
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
                                      pet.name,
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
                                  'ประเภท: ${pet.category}  •  สายพันธุ์: ${pet.breed}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF7A6551),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'อายุ: ${pet.age}  •  น้ำหนัก: ${pet.weight}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF7A6551),
                                  ),
                                ),
                              ],
                            ),
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
                            'ประวัติ: ${pet.history}',
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

  Widget _buildInfoSection({
    required String title,
    required List<_InfoRow> items,
  }) {
    return Container(
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5C3A21),
            ),
          ),
          const Divider(color: Color(0xFFE8DCCB), height: 20),
          ...items.map((row) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: [
                    Icon(row.icon, color: const Color(0xFF8C735B), size: 22),
                    const SizedBox(width: 12),
                    Text(
                      '${row.label}: ',
                      style: const TextStyle(fontSize: 14, color: Color(0xFF7A6551)),
                    ),
                    Expanded(
                      child: Text(
                        row.value,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _InfoRow {
  final IconData icon;
  final String label;
  final String value;

  _InfoRow({required this.icon, required this.label, required this.value});
}
