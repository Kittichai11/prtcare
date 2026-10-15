class PetItem {
  final String id;
  String name;
  String category;
  String breed;
  String age;
  String gender;
  bool isSpayed;
  String weight;
  String history;
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
  String type;

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

class UserAccount {
  String email;
  String password;
  String fullName;
  String phone;
  String? profileImagePath;
  List<PetItem> pets;
  List<FeedingItem> feedings;
  List<VaccineAppointmentItem> vaccines;
  List<DogWalkingItem> dogWalkings;
  List<MedicalRecordItem> records;
  List<NotificationItem> notifications;

  UserAccount({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phone,
    this.profileImagePath,
    List<PetItem>? pets,
    List<FeedingItem>? feedings,
    List<VaccineAppointmentItem>? vaccines,
    List<DogWalkingItem>? dogWalkings,
    List<MedicalRecordItem>? records,
    List<NotificationItem>? notifications,
  })  : pets = pets ?? [],
        feedings = feedings ?? [],
        vaccines = vaccines ?? [],
        dogWalkings = dogWalkings ?? [],
        records = records ?? [],
        notifications = notifications ?? [];
}

class OwnerProfile {
  String name;
  String email;
  String phone;
  String? imagePath;

  OwnerProfile({
    required this.name,
    required this.email,
    required this.phone,
    this.imagePath,
  });
}

class PetDataStore {
  // Registered Accounts Database
  static final List<UserAccount> registeredAccounts = [
    UserAccount(
      email: 'ggez.petowner@gmail.com',
      password: '123456',
      fullName: 'GGez',
      phone: '081-234-5678',
      pets: [
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
      ],
      feedings: [],
      vaccines: [],
      dogWalkings: [],
      records: [],
      notifications: [],
    ),
  ];

  static UserAccount? currentUserAccount;

  static UserAccount get currentUser {
    currentUserAccount ??= registeredAccounts.first;
    return currentUserAccount!;
  }

  static OwnerProfile get currentProfile => OwnerProfile(
        name: currentUser.fullName,
        email: currentUser.email,
        phone: currentUser.phone,
        imagePath: currentUser.profileImagePath,
      );

  static List<PetItem> get petsList => currentUser.pets;

  static int activePetIndex = 0;

  static PetItem? get activePet {
    if (petsList.isEmpty) return null;
    if (activePetIndex >= petsList.length) {
      activePetIndex = 0;
    }
    return petsList[activePetIndex];
  }

  static List<FeedingItem> get feedingList => currentUser.feedings;
  static List<VaccineAppointmentItem> get vaccineList => currentUser.vaccines;
  static List<DogWalkingItem> get dogWalkingList => currentUser.dogWalkings;
  static List<MedicalRecordItem> get recordList => currentUser.records;
  static List<NotificationItem> get notificationList => currentUser.notifications;

  // Real Authentication Methods
  static String? registerNewUser({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) {
    final normalizedEmail = email.trim().toLowerCase();
    final existingIndex = registeredAccounts.indexWhere(
      (acc) => acc.email.trim().toLowerCase() == normalizedEmail,
    );

    if (existingIndex != -1) {
      return 'อีเมลนี้ถูกใช้งานลงทะเบียนในระบบแล้ว';
    }

    final newAccount = UserAccount(
      email: normalizedEmail,
      password: password.trim(),
      fullName: fullName.trim(),
      phone: phone.trim(),
      pets: [],
      feedings: [],
      vaccines: [],
      dogWalkings: [],
      records: [],
      notifications: [],
    );

    registeredAccounts.add(newAccount);
    currentUserAccount = newAccount;
    activePetIndex = 0;
    return null; // Success
  }

  static String? loginUser({
    required String email,
    required String password,
  }) {
    final normalizedEmail = email.trim().toLowerCase();
    final accountIndex = registeredAccounts.indexWhere(
      (acc) => acc.email.trim().toLowerCase() == normalizedEmail,
    );

    if (accountIndex == -1) {
      return 'ไม่พบบัญชีอีเมลนี้ในระบบ กรุณาสมัครสมาชิกก่อนเข้าสู่ระบบ';
    }

    final account = registeredAccounts[accountIndex];
    if (account.password != password.trim()) {
      return 'รหัสผ่านไม่ถูกต้อง กรุณาตรวจสอบรหัสผ่านอีกครั้ง';
    }

    currentUserAccount = account;
    activePetIndex = 0;
    return null; // Success
  }

  static String? resetPassword({
    required String email,
    required String newPassword,
  }) {
    final normalizedEmail = email.trim().toLowerCase();
    final accountIndex = registeredAccounts.indexWhere(
      (acc) => acc.email.trim().toLowerCase() == normalizedEmail,
    );

    if (accountIndex == -1) {
      return 'ไม่พบบัญชีอีเมลนี้ในระบบ กรุณาตรวจสอบอีเมลอีกครั้ง';
    }

    registeredAccounts[accountIndex].password = newPassword.trim();
    return null; // Success
  }

  static void loginWithSocial({
    required String email,
    required String fullName,
  }) {
    final normalizedEmail = email.trim().toLowerCase();
    final accountIndex = registeredAccounts.indexWhere(
      (acc) => acc.email.trim().toLowerCase() == normalizedEmail,
    );

    if (accountIndex != -1) {
      currentUserAccount = registeredAccounts[accountIndex];
    } else {
      final newAccount = UserAccount(
        email: normalizedEmail,
        password: 'social_login_pwd',
        fullName: fullName,
        phone: '-',
        pets: [],
        feedings: [],
        vaccines: [],
        dogWalkings: [],
        records: [],
      );
      registeredAccounts.add(newAccount);
      currentUserAccount = newAccount;
    }
    activePetIndex = 0;
  }
}
