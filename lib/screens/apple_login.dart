import 'package:flutter/material.dart';

class AppleLoginScreen extends StatefulWidget {
  const AppleLoginScreen({super.key});

  @override
  State<AppleLoginScreen> createState() => _AppleLoginScreenState();
}

class _AppleLoginScreenState extends State<AppleLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _appleIdController = TextEditingController();

  @override
  void dispose() {
    _appleIdController.dispose();
    super.dispose();
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
          'Apple ID',
          style: TextStyle(
            color: Color(0xFF5C3A21),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Apple Logo Circle
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.apple,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'ลงชื่อเข้าใช้ด้วย Apple ID',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ป้อน Apple ID ของคุณเพื่อเข้าใช้งาน PetCare',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF7A6551),
                  ),
                ),
                const SizedBox(height: 32),

                // Apple ID Form
                Form(
                  key: _formKey,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _appleIdController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Color(0xFF333333), fontSize: 16),
                      decoration: const InputDecoration(
                        hintText: 'Apple ID (อีเมลหรือเบอร์โทรศัพท์)',
                        hintStyle: TextStyle(color: Color(0xFFA09385), fontSize: 15),
                        prefixIcon: Icon(Icons.apple, color: Colors.black),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'กรุณากรอก Apple ID';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Action Button
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('กำลังเข้าสู่ระบบด้วย Apple ID ${_appleIdController.text}'),
                            backgroundColor: Colors.black,
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'ดำเนินการต่อด้วย Apple ID',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Privacy Info
                const Center(
                  child: Text(
                    'การลงชื่อเข้าใช้ด้วย Apple จะคำนึงถึงความเป็นส่วนตัวของคุณ และคุณสามารถซ่อนอีเมลจริงของคุณได้',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8C735B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
