# 🐾 PetCare Flutter Application (prtcare)

แอปพลิเคชันสำหรับดูแลสัตว์เลี้ยงแบบครบวงจร พัฒนาด้วย **Flutter (Material Design 3)** รองรับระบบสมัครสมาชิก, เข้าสู่ระบบจริง, ระบบเปลี่ยนรหัสผ่าน, การจัดการสัตว์เลี้ยงหลายตัว, การแนบรูปภาพสัตว์เลี้ยงและรูปโปรไฟล์จริงจากคลังภาพ/กล้องถ่ายรูป, กำหนดเวลาให้อาหาร, นัดพบสัตวแพทย์/วัคซีน, PETS Walking, สมุดบันทึกการรักษา และระบบเปิด-ปิดซ่อนข้อมูลเพื่อความเป็นส่วนตัว (Eye Visibility Toggle)

---

## 🚀 วิธีอัปโหลดโปรเจกต์ขึ้น GitHub (สำหรับเจ้าของโปรเจกต์)

พิมพ์คำสั่งต่อไปนี้ใน **Terminal** ในโฟลเดอร์โปรเจกต์เพื่อส่งซอร์สโค้ดขึ้น GitHub:

```bash
# 1. เริ่มต้น Git Repository
git init

# 2. เพิ่มไฟล์ทั้งหมดเข้าสู่ Git
git add .

# 3. บันทึก Commit
git commit -m "Initial PetCare Flutter App with Auth & Full Features"

# 4. เปลี่ยนชื่อ Branch หลักเป็น main
git branch -M main

# 5. เชื่อมต่อกับ GitHub Repository ของคุณ (เปลี่ยน USERNAME และ REPO_NAME เป็นของคุณ)
git remote add origin https://github.com/USERNAME/REPO_NAME.git

# 6. Push โค้ดขึ้น GitHub
git push -u origin main
```

---

## 👥 วิธีสำหรับเพื่อนหรือผู้พัฒนาคนอื่นในการดาวน์โหลดไปรันและแก้ไขต่อ

เมื่ออัปโหลดขึ้น GitHub แล้ว ผู้อื่นสามารถดาวน์โหลดโปรเจกต์ไปพัฒนาต่อได้ง่ายๆ ดังนี้:

```bash
# 1. Clone โปรเจกต์ลงเครื่อง
git clone https://github.com/USERNAME/REPO_NAME.git

# 2. เข้าสู่โฟลเดอร์โปรเจกต์
cd REPO_NAME

# 3. ติดตั้ง Dependencies ทั้งหมด
flutter pub get

# 4. สั่งรันแอปพลิเคชัน
flutter run
```

---

## ☁️ การเชื่อมต่อกับฐานข้อมูลคลาวด์ (Cloud Database Integration)

เพื่อให้ผู้ใช้หรือผู้พัฒนาทุกคนสามารถเข้าถึงและแก้ไขข้อมูลสัตว์เลี้ยง (Pets, Feeding, Vaccines, Records) ร่วมกันแบบ Real-time ข้ามอุปกรณ์ได้ แนะนำการเชื่อมต่อ **Firebase Cloud Firestore**:

### ขั้นตอนการเชื่อมต่อ Firebase Firestore:
1. ไปที่ [Firebase Console](https://console.firebase.google.com/) แล้วกดสร้างโปรเจกต์ใหม่
2. ติดตั้ง **FlutterFire CLI** และสั่งรันใน Terminal:
   ```bash
   npm install -g firebase-tools
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
3. เพิ่ม Dependencies ใน `pubspec.yaml`:
   ```yaml
   dependencies:
     firebase_core: ^2.24.0
     cloud_firestore: ^4.13.0
   ```
4. ข้อมูลในคลาวด์จะถูกจัดเก็บและซิงค์แบบ Real-time ในโครงสร้างตาราง:
   - `users`: จัดเก็บข้อมูลบัญชีผู้ใช้ (Email, Password, Name, Phone)
   - `pets`: จัดเก็บข้อมูลสัตว์เลี้ยงของผู้ใช้แต่ละคน
   - `feedings`: จัดเก็บเวลาให้อาหาร
   - `vaccines`: จัดเก็บวันนัดสัตวแพทย์และวัคซีน
   - `dog_walkings`: จัดเก็บกำหนดการ PETS Walking
   - `records`: จัดเก็บสมุดบันทึกการรักษา

---

## 🛠️ โครงสร้างไฟล์ในโปรเจกต์ (Project Structure)

```text
lib/
├── models/
│   └── pet_data.dart              # Data Models & Centralized Auth/Data Store Manager
├── screens/
│   ├── login.dart                 # หน้าเข้าสู่ระบบ (Email/Password & Social Login)
│   ├── register.dart              # หน้าสมัครสมาชิกสร้าง ID ใหม่
│   ├── forgot_password_screen.dart # หน้าลืมรหัสผ่านและตั้งรหัสผ่านใหม่
│   ├── google_login.dart          # หน้าลงชื่อเข้าใช้ด้วย Google
│   ├── apple_login.dart           # หน้าลงชื่อเข้าใช้ด้วย Apple ID
│   ├── home_screen.dart           # หน้าหลัก (Dashboard, สัตว์เลี้ยง, แจ้งเตือนวันนี้)
│   ├── feeding_screen.dart        # หน้าตั้งเวลาให้อาหาร
│   ├── vaccine_screen.dart        # หน้านัดพบสัตวแพทย์ & ฉีดวัคซีน
│   ├── dog_walking_screen.dart    # หน้า PETS Walking & ออกกำลังกาย
│   ├── records_screen.dart        # หน้าสมุดบันทึกการรักษาพยาบาล
│   ├── notifications_screen.dart  # หน้าศูนย์แจ้งเตือน
│   ├── profile_screen.dart        # หน้าโปรไฟล์เจ้าของ ID (มีปุ่มลูกตาซ่อนข้อมูล)
│   └── add_pet_screen.dart        # หน้าเพิ่มสัตว์เลี้ยงใหม่ (เลือกรูปภาพจาก Gallery/Camera)
└── main.dart                      # จุดเริ่มต้นโปรเจกต์
```
