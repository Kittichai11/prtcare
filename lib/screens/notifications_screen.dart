import 'package:flutter/material.dart';
import '../models/pet_data.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationItem> _notifications = PetDataStore.notificationList;

  void _markAllAsRead() {
    setState(() {
      for (var item in _notifications) {
        item.isRead = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('อ่านรายการแจ้งเตือนทั้งหมดแล้ว'),
        backgroundColor: Color(0xFF673D17),
      ),
    );
  }

  void _clearNotifications() {
    setState(() {
      _notifications.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ล้างการแจ้งเตือนทั้งหมดแล้ว'),
        backgroundColor: Color(0xFF673D17),
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
          'รายการแจ้งเตือน',
          style: TextStyle(
            color: Color(0xFF5C3A21),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded, color: Color(0xFF5C3A21)),
            onSelected: (value) {
              if (value == 'read_all') {
                _markAllAsRead();
              } else if (value == 'clear_all') {
                _clearNotifications();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'read_all',
                child: Text('ทำเครื่องหมายว่าอ่านแล้วทั้งหมด'),
              ),
              const PopupMenuItem(
                value: 'clear_all',
                child: Text('ล้างการแจ้งเตือนทั้งหมด', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'การแจ้งเตือนทั้งหมด',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C3A21),
                    ),
                  ),
                  Text(
                    '${_notifications.where((n) => !n.isRead).length} รายการยังไม่อ่าน',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF8C735B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Expanded(
                child: _notifications.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.notifications_off_outlined, size: 64, color: Colors.brown[300]),
                            const SizedBox(height: 12),
                            const Text(
                              'ไม่มีรายการแจ้งเตือนในขณะนี้',
                              style: TextStyle(fontSize: 16, color: Color(0xFF8C735B)),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _notifications.length,
                        itemBuilder: (context, index) {
                          final item = _notifications[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: item.isRead ? Colors.white : const Color(0xFFFFF7EF),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: item.isRead
                                    ? Colors.transparent
                                    : const Color(0xFFD8B896),
                                width: 1.5,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: item.isRead
                                        ? const Color(0xFFF2E7DC)
                                        : const Color(0xFF673D17),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.notifications_active_rounded,
                                    color: item.isRead
                                        ? const Color(0xFF8C735B)
                                        : Colors.white,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.title,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: item.isRead
                                                    ? const Color(0xFF555555)
                                                    : const Color(0xFF333333),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            item.time,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF8C735B),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        item.message,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: item.isRead
                                              ? const Color(0xFF777777)
                                              : const Color(0xFF4A3525),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
