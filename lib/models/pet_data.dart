class PetItem {
  final String id;
  String name;
  String category; // ประเภทสัตว์เลี้ยง e.g. 'สุนัข', 'แมว', 'กระต่าย', 'นก'
  String breed;    // สายพันธุ์
  String age;      // อายุ
  String gender;   // 'ผู้ ♂' or 'เมีย ♀'
  bool isSpayed;   // สถานะทำหมัน (เฉพาะเพศเมีย)
  String weight;   // น้ำหนัก e.g. '8.5 กก.'
  String history;  // ประวัติของสัตว์เลี้ยง
  String? imagePath;

  PetItem({
    required this.id,
    required this.name,
    required this.category,
    required this.breed,
    required this.age,
    required this.gender,
    this.isSpayed = false,
    required this.weight,
    required this.history,
    this.imagePath,
  });
}

class FeedingItem {
  final String id;
  String title;
  String time;
  bool isNearTime;

  FeedingItem({
    required this.id,
    required this.title,
    required this.time,
    this.isNearTime = false,
  });
}

class VaccineAppointmentItem {
  final String id;
  String title;
  String date;
  int daysLeft;
  String reminderTime;
  String type; // 'วัคซีน' or 'ตรวจสุขภาพ'

  VaccineAppointmentItem({
    required this.id,
    required this.title,
    required this.date,
    required this.daysLeft,
    required this.reminderTime,
    required this.type,
  });
}

class DogWalkingItem {
  final String id;
  String title;
  String time;
  String daysOrDate;
  String activityType;
  String duration;

  DogWalkingItem({
    required this.id,
    required this.title,
    required this.time,
    required this.daysOrDate,
    required this.activityType,
    required this.duration,
  });
}

class MedicalRecordItem {
  final String id;
  String title;
  String date;
  String clinic;
  String details;
  String doctor;

  MedicalRecordItem({
    required this.id,
    required this.title,
    required this.date,
    required this.clinic,
    required this.details,
    required this.doctor,
  });
}

class NotificationItem {
  final String id;
  String title;
  String message;
  String time;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}

class OwnerProfile {
  String name;
  String email;
  String phone;

  OwnerProfile({
    required this.name,
    required this.email,
    required this.phone,
  });
}

class PetDataStore {
  static OwnerProfile currentProfile = OwnerProfile(
    name: 'GGez',
    email: 'ggez.petowner@gmail.com',
    phone: '081-234-5678',
  );

  static List<PetItem> petsList = [
    PetItem(
      id: '1',
      name: 'Doge',
      category: 'สุนัข',
      breed: 'ชิบะ',
      age: '2 ปี 4 เดือน',
      gender: 'ผู้ ♂',
      isSpayed: false,
      weight: '8.5 กก.',
      history: 'วัคซีนครบตามกำหนด สุขภาพร่าเริง แจ่มใส ชอบทานอาหารเม็ดรสไก่',
    ),
  ];

  static int activePetIndex = 0;

  static PetItem get activePet => petsList[activePetIndex];

  static List<FeedingItem> feedingList = [
    FeedingItem(
      id: '1',
      title: 'ให้อาหารเช้า',
      time: '08:00 น.',
      isNearTime: false,
    ),
    FeedingItem(
      id: '2',
      title: 'ให้อาหารเย็น',
      time: '18:00 น.',
      isNearTime: true,
    ),
  ];

  static List<VaccineAppointmentItem> vaccineList = [
    VaccineAppointmentItem(
      id: '1',
      title: 'นัดพบสัตวแพทย์',
      date: '31 ส.ค. 2026',
      daysLeft: 25,
      reminderTime: '10:00 น.',
      type: 'ตรวจสุขภาพ',
    ),
    VaccineAppointmentItem(
      id: '2',
      title: 'วัคซีนพิษสุนัขบ้า',
      date: '15 ส.ค. 2026',
      daysLeft: 9,
      reminderTime: '09:00 น.',
      type: 'วัคซีน',
    ),
  ];

  static List<DogWalkingItem> dogWalkingList = [
    DogWalkingItem(
      id: '1',
      title: 'พาสัตว์เลี้ยงออกไปเดินเล่นประจำวัน',
      time: '17:00 น.',
      daysOrDate: 'ทุกวันเย็น',
      activityType: 'เดินเล่น',
      duration: '30 นาที',
    ),
    DogWalkingItem(
      id: '2',
      title: 'วิ่งออกกำลังกายสวนสาธารณะ',
      time: '07:00 น.',
      daysOrDate: 'เสาร์-อาทิตย์',
      activityType: 'วิ่งออกกำลังกาย',
      duration: '45 นาที',
    ),
  ];

  static List<MedicalRecordItem> recordList = [
    MedicalRecordItem(
      id: '1',
      title: 'ตรวจสุขภาพประจำปีและฉีดวัคซีนรวม',
      date: '10 มิ.ย. 2026',
      clinic: 'โรงพยาบาลสัตว์ทองหล่อ',
      details: 'น้ำหนัก 8.5 กก. สุขภาพสมบูรณ์ดี ไม่พบพยาธิ',
      doctor: 'สพ.ญ. สมศรี ใจดี',
    ),
    MedicalRecordItem(
      id: '2',
      title: 'ถ่ายพยาธิและหยดยาป้องกันเห็บเหา',
      date: '15 เม.ย. 2026',
      clinic: 'คลินิกสัตว์เลี้ยงรักสัตว์',
      details: 'หยดยา Frontline และรับยาทานถ่ายพยาธิ',
      doctor: 'น.สพ. วิชัย สุขเกษม',
    ),
  ];

  static List<NotificationItem> notificationList = [
    NotificationItem(
      id: '1',
      title: 'ใกล้ถึงเวลาให้อาหารเย็น',
      message: 'อย่าลืมให้อาหาร Doge เวลา 18:00 น.',
      time: '17:30 น.',
      isRead: false,
    ),
    NotificationItem(
      id: '2',
      title: 'เตือนเวลา Dog Walking',
      message: 'ถึงเวลาพาสัตว์เลี้ยงออกไปเดินเล่น 17:00 น.',
      time: 'เมื่อวานนี้',
      isRead: true,
    ),
    NotificationItem(
      id: '3',
      title: 'เตือนนัดพบสัตวแพทย์',
      message: 'นัดตรวจสุขภาพวันที่ 31 ส.ค. 2026',
      time: '3 วันที่แล้ว',
      isRead: true,
    ),
  ];
}
