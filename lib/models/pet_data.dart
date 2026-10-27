import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget buildAppImage({
  required String imagePath,
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  Widget? fallbackIcon,
}) {
  if (kIsWeb || imagePath.startsWith('http') || imagePath.startsWith('blob:')) {
    return Image.network(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) =>
          fallbackIcon ??
          Container(
            color: const Color(0xFFFFF0E5),
            child: const Icon(Icons.pets_rounded, color: Color(0xFF673D17), size: 32),
          ),
    );
  } else {
    return Image.file(
      File(imagePath),
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) =>
          fallbackIcon ??
          Container(
            color: const Color(0xFFFFF0E5),
            child: const Icon(Icons.pets_rounded, color: Color(0xFF673D17), size: 32),
          ),
    );
  }
}

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'breed': breed,
        'age': age,
        'gender': gender,
        'isSpayed': isSpayed,
        'weight': weight,
        'history': history,
        'imagePath': imagePath,
      };

  factory PetItem.fromJson(Map<String, dynamic> json) => PetItem(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        category: json['category'] ?? '',
        breed: json['breed'] ?? '',
        age: json['age'] ?? '',
        gender: json['gender'] ?? '',
        isSpayed: json['isSpayed'] ?? false,
        weight: json['weight'] ?? '',
        history: json['history'] ?? '',
        imagePath: json['imagePath'],
      );
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'time': time,
        'isNearTime': isNearTime,
      };

  factory FeedingItem.fromJson(Map<String, dynamic> json) => FeedingItem(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        time: json['time'] ?? '',
        isNearTime: json['isNearTime'] ?? false,
      );
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date,
        'daysLeft': daysLeft,
        'reminderTime': reminderTime,
        'type': type,
      };

  factory VaccineAppointmentItem.fromJson(Map<String, dynamic> json) => VaccineAppointmentItem(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        date: json['date'] ?? '',
        daysLeft: json['daysLeft'] ?? 0,
        reminderTime: json['reminderTime'] ?? '',
        type: json['type'] ?? '',
      );
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'time': time,
        'daysOrDate': daysOrDate,
        'activityType': activityType,
        'duration': duration,
      };

  factory DogWalkingItem.fromJson(Map<String, dynamic> json) => DogWalkingItem(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        time: json['time'] ?? '',
        daysOrDate: json['daysOrDate'] ?? '',
        activityType: json['activityType'] ?? '',
        duration: json['duration'] ?? '',
      );
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date,
        'clinic': clinic,
        'details': details,
        'doctor': doctor,
      };

  factory MedicalRecordItem.fromJson(Map<String, dynamic> json) => MedicalRecordItem(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        date: json['date'] ?? '',
        clinic: json['clinic'] ?? '',
        details: json['details'] ?? '',
        doctor: json['doctor'] ?? '',
      );
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'message': message,
        'time': time,
        'isRead': isRead,
      };

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        message: json['message'] ?? '',
        time: json['time'] ?? '',
        isRead: json['isRead'] ?? false,
      );
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

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'fullName': fullName,
        'phone': phone,
        'profileImagePath': profileImagePath,
        'pets': pets.map((x) => x.toJson()).toList(),
        'feedings': feedings.map((x) => x.toJson()).toList(),
        'vaccines': vaccines.map((x) => x.toJson()).toList(),
        'dogWalkings': dogWalkings.map((x) => x.toJson()).toList(),
        'records': records.map((x) => x.toJson()).toList(),
        'notifications': notifications.map((x) => x.toJson()).toList(),
      };

  factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        fullName: json['fullName'] ?? '',
        phone: json['phone'] ?? '',
        profileImagePath: json['profileImagePath'],
        pets: json['pets'] != null
            ? (json['pets'] as List).map((x) => PetItem.fromJson(x)).toList()
            : [],
        feedings: json['feedings'] != null
            ? (json['feedings'] as List).map((x) => FeedingItem.fromJson(x)).toList()
            : [],
        vaccines: json['vaccines'] != null
            ? (json['vaccines'] as List).map((x) => VaccineAppointmentItem.fromJson(x)).toList()
            : [],
        dogWalkings: json['dogWalkings'] != null
            ? (json['dogWalkings'] as List).map((x) => DogWalkingItem.fromJson(x)).toList()
            : [],
        records: json['records'] != null
            ? (json['records'] as List).map((x) => MedicalRecordItem.fromJson(x)).toList()
            : [],
        notifications: json['notifications'] != null
            ? (json['notifications'] as List).map((x) => NotificationItem.fromJson(x)).toList()
            : [],
      );
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
  static const String _accountsKey = 'petcare_registered_accounts_db';
  static const String _sessionKey = 'petcare_active_user_email_session';

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

  // Load persisted accounts & active session from device storage
  static Future<void> loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? accountsJsonStr = prefs.getString(_accountsKey);
      final String? activeEmail = prefs.getString(_sessionKey);

      if (accountsJsonStr != null && accountsJsonStr.isNotEmpty) {
        final List<dynamic> jsonList = jsonDecode(accountsJsonStr);
        registeredAccounts.clear();
        for (var item in jsonList) {
          registeredAccounts.add(UserAccount.fromJson(item));
        }
      }

      if (activeEmail != null && activeEmail.isNotEmpty) {
        final idx = registeredAccounts.indexWhere(
          (acc) => acc.email.trim().toLowerCase() == activeEmail.trim().toLowerCase(),
        );
        if (idx != -1) {
          currentUserAccount = registeredAccounts[idx];
        }
      }
    } catch (e) {
      debugPrint('Error loading storage: $e');
    }
  }

  // Save current accounts & active session to device storage
  static Future<void> saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = registeredAccounts.map((acc) => acc.toJson()).toList();
      await prefs.setString(_accountsKey, jsonEncode(jsonList));
      if (currentUserAccount != null) {
        await prefs.setString(_sessionKey, currentUserAccount!.email);
      }
    } catch (e) {
      debugPrint('Error saving storage: $e');
    }
  }

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
    saveToStorage();
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
    saveToStorage();
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
    saveToStorage();
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
    saveToStorage();
  }

  static void logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_sessionKey);
      currentUserAccount = null;
    } catch (e) {
      debugPrint('Error logging out: $e');
    }
  }
}
