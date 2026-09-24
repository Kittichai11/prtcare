import 'package:flutter/material.dart';
import 'register.dart';
import 'google_login.dart';
import 'apple_login.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EEDD),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),

                // PetCare Logo Title
                const Text(
                  'PetCare',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5C3A21),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Cute Pet Illustration Graphic (Dog & Cat)
                const Center(
                  child: PetIllustrationWidget(),
                ),
                const SizedBox(height: 24),

                // Form Fields
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email / Username Input
                      _buildTextField(
                        controller: _emailController,
                        hintText: 'อีเมล / ชื่อผู้ใช้',
                        icon: Icons.person_outline_rounded,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 14),

                      // Password Input
                      _buildTextField(
                        controller: _passwordController,
                        hintText: 'รหัสผ่าน',
                        icon: Icons.lock_outline_rounded,
                        isPassword: true,
                        obscureText: _obscurePassword,
                        onTogglePassword: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Primary Login Button "เข้าสู่ระบบ" -> Navigate to HomeScreen
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
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
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Register Link "สมัครสมาชิก" -> Navigate to RegisterScreen
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'สมัครสมาชิก',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF673D17),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF673D17),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Divider "- หรือ -"
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFFCBB69D),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '-หรือ-',
                        style: TextStyle(
                          color: Color(0xFF7A6551),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFFCBB69D),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Social Login Button 1: Google -> Navigate to GoogleLoginScreen
                _buildSocialButton(
                  iconWidget: const GoogleLogoWidget(),
                  label: 'เข้าสู่ระบบด้วย Google',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GoogleLoginScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 14),

                // Social Login Button 2: Apple -> Navigate to AppleLoginScreen
                _buildSocialButton(
                  iconWidget: const Icon(
                    Icons.apple,
                    color: Colors.black,
                    size: 26,
                  ),
                  label: 'เข้าสู่ระบบด้วย Apple',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AppleLoginScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onTogglePassword,
  }) {
    return Container(
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
        controller: controller,
        obscureText: isPassword ? obscureText : false,
        keyboardType: keyboardType,
        style: const TextStyle(color: Color(0xFF333333), fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFFA09385), fontSize: 15),
          prefixIcon: Icon(icon, color: const Color(0xFF8C735B)),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFF8C735B),
                  ),
                  onPressed: onTogglePassword,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'กรุณากรอก$hintText';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSocialButton({
    required Widget iconWidget,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF333333),
          elevation: 1,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: const BorderSide(color: Color(0xFFE8DCCB), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PetIllustrationWidget extends StatelessWidget {
  const PetIllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 130,
      child: CustomPaint(
        painter: PetIllustrationPainter(),
      ),
    );
  }
}

class PetIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final darkBrown = Paint()
      ..color = const Color(0xFF5C3A21)
      ..style = PaintingStyle.fill;

    final mediumBrown = Paint()
      ..color = const Color(0xFF8B5A2B)
      ..style = PaintingStyle.fill;

    final lightBrown = Paint()
      ..color = const Color(0xFFC4A482)
      ..style = PaintingStyle.fill;

    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final pinkPaint = Paint()
      ..color = const Color(0xFFE8A598)
      ..style = PaintingStyle.fill;

    // --- Paw Print at Top ---
    final pawCenter = Offset(size.width * 0.5, size.height * 0.16);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(pawCenter.dx, pawCenter.dy + 3), width: 16, height: 12),
      darkBrown,
    );
    canvas.drawCircle(Offset(pawCenter.dx - 8, pawCenter.dy - 4), 3, darkBrown);
    canvas.drawCircle(Offset(pawCenter.dx - 3, pawCenter.dy - 7), 3, darkBrown);
    canvas.drawCircle(Offset(pawCenter.dx + 3, pawCenter.dy - 7), 3, darkBrown);
    canvas.drawCircle(Offset(pawCenter.dx + 8, pawCenter.dy - 4), 3, darkBrown);

    // --- Dog (Left) ---
    final dogCenter = Offset(size.width * 0.35, size.height * 0.62);
    canvas.drawCircle(dogCenter, 34, mediumBrown);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(dogCenter.dx, dogCenter.dy + 8),
        width: 30,
        height: 22,
      ),
      lightBrown,
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(dogCenter.dx, dogCenter.dy + 2),
        width: 12,
        height: 8,
      ),
      darkBrown,
    );

    canvas.drawCircle(Offset(dogCenter.dx - 11, dogCenter.dy - 8), 3.5, darkBrown);
    canvas.drawCircle(Offset(dogCenter.dx + 11, dogCenter.dy - 8), 3.5, darkBrown);
    canvas.drawCircle(Offset(dogCenter.dx - 12, dogCenter.dy - 9), 1.0, whitePaint);
    canvas.drawCircle(Offset(dogCenter.dx + 10, dogCenter.dy - 9), 1.0, whitePaint);

    final leftEarPath = Path()
      ..addOval(Rect.fromLTWH(dogCenter.dx - 42, dogCenter.dy - 28, 18, 34));
    canvas.drawPath(leftEarPath, darkBrown);

    final rightEarPath = Path()
      ..addOval(Rect.fromLTWH(dogCenter.dx + 24, dogCenter.dy - 28, 18, 34));
    canvas.drawPath(rightEarPath, darkBrown);

    // --- Cat (Right) ---
    final catCenter = Offset(size.width * 0.68, size.height * 0.65);
    canvas.drawCircle(catCenter, 28, lightBrown);

    final catLeftEar = Path()
      ..moveTo(catCenter.dx - 20, catCenter.dy - 14)
      ..lineTo(catCenter.dx - 26, catCenter.dy - 36)
      ..lineTo(catCenter.dx - 6, catCenter.dy - 24)
      ..close();
    canvas.drawPath(catLeftEar, darkBrown);

    final catRightEar = Path()
      ..moveTo(catCenter.dx + 6, catCenter.dy - 24)
      ..lineTo(catCenter.dx + 26, catCenter.dy - 36)
      ..lineTo(catCenter.dx + 20, catCenter.dy - 14)
      ..close();
    canvas.drawPath(catRightEar, darkBrown);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(catCenter.dx, catCenter.dy + 6),
        width: 20,
        height: 14,
      ),
      whitePaint,
    );
    canvas.drawCircle(Offset(catCenter.dx, catCenter.dy + 2), 2.5, pinkPaint);

    canvas.drawCircle(Offset(catCenter.dx - 9, catCenter.dy - 6), 3.0, darkBrown);
    canvas.drawCircle(Offset(catCenter.dx + 9, catCenter.dy - 6), 3.0, darkBrown);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GoogleLogoWidget extends StatelessWidget {
  const GoogleLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(
        painter: _GoogleLogoPainter(),
      ),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final red = Paint()..color = const Color(0xFFEA4335);
    final blue = Paint()..color = const Color(0xFF4285F4);
    final green = Paint()..color = const Color(0xFF34A853);
    final yellow = Paint()..color = const Color(0xFFFBBC05);

    final center = Offset(w / 2, h / 2);
    final radius = w / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);

    final bluePath = Path()
      ..addArc(rect, -0.5, 2.0)
      ..lineTo(center.dx, center.dy)
      ..close();
    canvas.drawPath(bluePath, blue);

    final redPath = Path()
      ..addArc(rect, 3.14, 1.5)
      ..lineTo(center.dx, center.dy)
      ..close();
    canvas.drawPath(redPath, red);

    final yellowPath = Path()
      ..addArc(rect, 2.2, 1.1)
      ..lineTo(center.dx, center.dy)
      ..close();
    canvas.drawPath(yellowPath, yellow);

    final greenPath = Path()
      ..addArc(rect, 0.8, 1.4)
      ..lineTo(center.dx, center.dy)
      ..close();
    canvas.drawPath(greenPath, green);

    final innerCutout = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius * 0.58, innerCutout);

    final barRect = Rect.fromLTWH(center.dx, center.dy - (radius * 0.2), radius, radius * 0.4);
    canvas.drawRect(barRect, blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
