import 'package:flutter/material.dart';
import '../models/pet_data.dart';
import 'feeding_screen.dart';
import 'vaccine_screen.dart';
import 'records_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'add_pet_screen.dart';
import 'dog_walking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _refreshState() {
    setState(() {});
  }

  void _showQuickAddModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF7EEDD),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'เลือกรายการที่ต้องการเพิ่ม',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5C3A21),
                ),
              ),
              const SizedBox(height: 18),

              _buildAddOptionTile(
                icon: Icons.pets_rounded,
                iconColor: const Color(0xFF673D17),
                title: 'เพิ่มสัตว์เลี้ยงใหม่',
                subtitle: 'กรอกชื่อ ประเภท รูปภาพ สายพันธุ์ เพศ น้ำหนัก และประวัติ',
                onTap: () async {
                  Navigator.pop(ctx);
                  final res = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddPetScreen()),
                  );
                  if (res == true) {
                    _refreshState();
                  }
                },
              ),
              const SizedBox(height: 10),

              _buildAddOptionTile(
                icon: Icons.restaurant_rounded,
                iconColor: const Color(0xFFD86A38),
                title: 'เพิ่มเวลาให้อาหาร',
                subtitle: 'ตั้งเวลาแจ้งเตือนมื้ออาหารของสัตว์เลี้ยง',
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FeedingScreen()),
                  );
                },
              ),
              const SizedBox(height: 10),

              _buildAddOptionTile(
                icon: Icons.directions_run_rounded,
                iconColor: const Color(0xFF2B78C5),
                title: 'ตั้งวันและเวลา Dog Walking',
                subtitle: 'พาสัตว์เลี้ยงออกไปเดินเล่นและออกกำลังกาย',
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DogWalkingScreen()),
                  );
                },
              ),
              const SizedBox(height: 10),

              _buildAddOptionTile(
                icon: Icons.calendar_month_rounded,
                iconColor: const Color(0xFFD84A38),
                title: 'เพิ่มวันนัดสัตวแพทย์ / วัคซีน',
                subtitle: 'ตั้งค่าวันนัดหมายและเวลาแจ้งเตือน',
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VaccineScreen()),
                  );
                },
              ),
              const SizedBox(height: 10),

              _buildAddOptionTile(
                icon: Icons.assignment_rounded,
                iconColor: const Color(0xFF5C3A21),
                title: 'เพิ่มสมุดบันทึกการรักษา',
                subtitle: 'บันทึกประวัติสุขภาพและการรักษาพยาบาล',
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RecordsScreen()),
                  );
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddOptionTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7A6551),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF8C735B), size: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _HomeDashboardTab(onPetChanged: _refreshState),
      const RecordsScreen(),
      const NotificationsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7EEDD),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Color(0xFFD8B896),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home Tab
            _buildNavItem(
              index: 0,
              icon: Icons.home_rounded,
              label: 'หน้าหลัก',
            ),
            // Records Tab
            _buildNavItem(
              index: 1,
              icon: Icons.edit_note_rounded,
              label: 'บันทึก',
            ),
            // Center Floating Action Button
            GestureDetector(
              onTap: _showQuickAddModal,
              child: Container(
                width: 54,
                height: 54,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add_rounded,
                  size: 38,
                  color: Color(0xFF8C6239),
                ),
              ),
            ),
            // Notifications Tab
            _buildNavItem(
              index: 2,
              icon: Icons.notifications_rounded,
              label: 'แจ้งเตือน',
            ),
            // Profile Tab
            _buildNavItem(
              index: 3,
              icon: Icons.person_rounded,
              label: 'โปรไฟล์',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? const Color(0xFF4A2810) : const Color(0xFF7A5C3E);

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: color,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// Home Dashboard Content
class _HomeDashboardTab extends StatefulWidget {
  final VoidCallback onPetChanged;
  const _HomeDashboardTab({required this.onPetChanged});

  @override
  State<_HomeDashboardTab> createState() => _HomeDashboardTabState();
}

class _HomeDashboardTabState extends State<_HomeDashboardTab> {
  @override
  Widget build(BuildContext context) {
    final profile = PetDataStore.currentProfile;
    final pet = PetDataStore.activePet;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Bar: "สวัสดีคุณ GGez" + Avatar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'สวัสดีคุณ ${profile.name}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFF673D17),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Color(0xFFF7EEDD),
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Pet Selector Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<int>(
                  value: PetDataStore.activePetIndex,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF5C3A21)),
                  items: List.generate(
                    PetDataStore.petsList.length,
                    (idx) => DropdownMenuItem(
                      value: idx,
                      child: Text(
                        'สัตว์เลี้ยง: ${PetDataStore.petsList[idx].name}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5C3A21),
                        ),
                      ),
                    ),
                  ),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        PetDataStore.activePetIndex = val;
                      });
                      widget.onPetChanged();
                    }
                  },
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final res = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddPetScreen()),
                    );
                    if (res == true) {
                      setState(() {});
                      widget.onPetChanged();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673D17),
                    foregroundColor: Colors.white,
                    elevation: 1,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('เพิ่มสัตว์เลี้ยง', style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Main Pet Info Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFD8B896),
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Pet Picture Box
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          child: ShibaAvatarWidget(),
                        ),
                      ),
                      const SizedBox(width: 18),

                      // Pet Details Text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  pet.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  pet.gender,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: pet.gender.contains('ผู้')
                                        ? const Color(0xFF2B78C5)
                                        : const Color(0xFFE84A5F),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${pet.category} • ${pet.breed}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF4A3525),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'อายุ ${pet.age}  •  น้ำหนัก ${pet.weight}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF5C4332),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (pet.history.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        'ประวัติสัตว์เลี้ยง: ${pet.history}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF4A3525),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Today's Reminders Header
            const Text(
              'แจ้งเตือนวันนี้',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),

            // Card 1: เวลาการให้อาหาร (Feeding Times Card)
            _buildReminderCard(
              context: context,
              iconWidget: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF0E5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.restaurant_rounded,
                  color: Color(0xFFD86A38),
                  size: 28,
                ),
              ),
              title: 'เวลาการให้อาหาร',
              timeText: '18:00 น.',
              badgeText: 'ใกล้ถึงเวลา',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FeedingScreen()),
                );
              },
            ),
            const SizedBox(height: 14),

            // Card 2: นัดพบสัตวแพทย์ (Vet Appointment Card)
            _buildReminderCard(
              context: context,
              iconWidget: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF6E5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: Color(0xFF8C6239),
                  size: 28,
                ),
              ),
              title: 'นัดพบสัตวแพทย์',
              timeText: 'อีก 25 วัน      31 ส.ค. 2026',
              badgeText: null,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VaccineScreen()),
                );
              },
            ),
            const SizedBox(height: 14),

            // Card 3: Dog Walking (Running/Walking Icon Card)
            _buildReminderCard(
              context: context,
              iconWidget: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFEBF5FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.directions_run_rounded,
                  color: Color(0xFF2B78C5),
                  size: 28,
                ),
              ),
              title: 'Dog Walking',
              timeText: '17:00 น.        ทุกวันเย็น',
              badgeText: null,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DogWalkingScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderCard({
    required BuildContext context,
    required Widget iconWidget,
    required String title,
    required String timeText,
    required String? badgeText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
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
            SizedBox(
              width: 48,
              height: 48,
              child: Center(child: iconWidget),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeText,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF555555),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (badgeText != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF673D17),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Custom Shiba Dog Avatar Illustration
class ShibaAvatarWidget extends StatelessWidget {
  const ShibaAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ShibaPainter(),
    );
  }
}

class _ShibaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final orange = Paint()..color = const Color(0xFFD27D2D);
    final darkOrange = Paint()..color = const Color(0xFFB5651D);
    final cream = Paint()..color = const Color(0xFFFFF5E1);
    final black = Paint()..color = const Color(0xFF222222);
    final pink = Paint()..color = const Color(0xFFFFB3BA);

    final w = size.width;
    final h = size.height;

    // Background fill
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), Paint()..color = const Color(0xFFFFF8F0));

    // Ears
    final leftEar = Path()
      ..moveTo(w * 0.2, h * 0.4)
      ..lineTo(w * 0.15, h * 0.12)
      ..lineTo(w * 0.4, h * 0.28)
      ..close();
    canvas.drawPath(leftEar, darkOrange);

    final rightEar = Path()
      ..moveTo(w * 0.8, h * 0.4)
      ..lineTo(w * 0.85, h * 0.12)
      ..lineTo(w * 0.6, h * 0.28)
      ..close();
    canvas.drawPath(rightEar, darkOrange);

    // Head Base
    canvas.drawCircle(Offset(w * 0.5, h * 0.52), w * 0.38, orange);

    // Muzzle / White Cheek Fur
    final cheekPath = Path()
      ..moveTo(w * 0.2, h * 0.62)
      ..quadraticBezierTo(w * 0.5, h * 0.35, w * 0.8, h * 0.62)
      ..quadraticBezierTo(w * 0.5, h * 0.95, w * 0.2, h * 0.62)
      ..close();
    canvas.drawPath(cheekPath, cream);

    // Nose
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.5, h * 0.60), width: w * 0.18, height: h * 0.12),
      black,
    );

    // Mouth
    final mouthPath = Path()
      ..moveTo(w * 0.5, h * 0.66)
      ..lineTo(w * 0.5, h * 0.72);
    canvas.drawPath(mouthPath, Paint()..color = black.color..style = PaintingStyle.stroke..strokeWidth = 2);

    // Tongue
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.5, h * 0.76), width: w * 0.14, height: h * 0.12),
      pink,
    );

    // Eyes
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.32, h * 0.46), width: w * 0.08, height: h * 0.11),
      black,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.68, h * 0.46), width: w * 0.08, height: h * 0.11),
      black,
    );

    // Eyebrows (Cream dots)
    canvas.drawCircle(Offset(w * 0.34, h * 0.36), w * 0.045, cream);
    canvas.drawCircle(Offset(w * 0.66, h * 0.36), w * 0.045, cream);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Food Bowl Icon
class BowlIconWidget extends StatelessWidget {
  const BowlIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _BowlPainter());
  }
}

class _BowlPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final bowlColor = Paint()..color = const Color(0xFFE85D36);
    final foodColor = Paint()..color = const Color(0xFF7A4B23);
    final shadowColor = Paint()..color = const Color(0xFFC44824);

    // Food mound
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.5, h * 0.40), width: w * 0.72, height: h * 0.36),
      foodColor,
    );

    // Kibbles details
    final kibble = Paint()..color = const Color(0xFF9A6233);
    canvas.drawCircle(Offset(w * 0.38, h * 0.32), 3, kibble);
    canvas.drawCircle(Offset(w * 0.52, h * 0.28), 3.5, kibble);
    canvas.drawCircle(Offset(w * 0.62, h * 0.36), 3, kibble);

    // Bowl Body
    final bowlPath = Path()
      ..moveTo(w * 0.10, h * 0.42)
      ..lineTo(w * 0.18, h * 0.80)
      ..quadraticBezierTo(w * 0.5, h * 0.95, w * 0.82, h * 0.80)
      ..lineTo(w * 0.90, h * 0.42)
      ..close();
    canvas.drawPath(bowlPath, bowlColor);

    // Bowl Rim
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.5, h * 0.42), width: w * 0.82, height: h * 0.18),
      shadowColor,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Calendar Icon
class CalendarIconWidget extends StatelessWidget {
  const CalendarIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _CalendarPainter());
  }
}

class _CalendarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final body = Paint()..color = const Color(0xFF5C3A21);
    final grid = Paint()..color = const Color(0xFF8C6239);

    // Main Box
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.15, h * 0.18, w * 0.70, h * 0.68),
        const Radius.circular(8),
      ),
      Paint()..color = Colors.white..style = PaintingStyle.fill,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.15, h * 0.18, w * 0.70, h * 0.68),
        const Radius.circular(8),
      ),
      body..style = PaintingStyle.stroke..strokeWidth = 2.5,
    );

    // Top Header
    final headerPath = Path()
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(w * 0.15, h * 0.18, w * 0.70, h * 0.18),
        topLeft: const Radius.circular(8),
        topRight: const Radius.circular(8),
      ));
    canvas.drawPath(headerPath, Paint()..color = const Color(0xFF8C6239));

    // Rings
    canvas.drawRect(Rect.fromLTWH(w * 0.32, h * 0.10, 3, 8), body);
    canvas.drawRect(Rect.fromLTWH(w * 0.68, h * 0.10, 3, 8), body);

    // Grid dots
    for (int r = 0; r < 2; r++) {
      for (int c = 0; c < 3; c++) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              w * 0.28 + (c * w * 0.18),
              h * 0.44 + (r * h * 0.16),
              w * 0.10,
              h * 0.09,
            ),
            const Radius.circular(2),
          ),
          grid,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
