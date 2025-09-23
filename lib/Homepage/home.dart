import 'package:flutter/material.dart';
import 'add.dart';
import 'list.dart';
import '../Drawer/drawer.dart';
import 'notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  // จำนวนการแจ้งเตือนที่ยังไม่ได้อ่าน (จำลอง)
  int _unreadNotificationCount = 2;

  @override
  void initState() {
    super.initState();
    // จำลองการอัพเดทการแจ้งเตือนแบบ real-time
    _simulateNotificationUpdates();
  }

  // ฟังก์ชันจำลองการอัพเดทการแจ้งเตือน
  void _simulateNotificationUpdates() {
    // จำลองการแจ้งเตือนใหม่เข้ามาทุก 30 วินาที
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted) {
        setState(() {
          _unreadNotificationCount += 1;
        });
        _simulateNotificationUpdates(); // เรียกซ้ำ
      }
    });
  }

  // (notification adding removed - simulation continues via _simulateNotificationUpdates)
  
  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        _selectedIndex = 0; // หน้าแรก
      } else if (index == 1) {
        _selectedIndex = 2; // รายการ (index 2 ใน IndexedStack)
      }
    });
  }
  // ฟังก์ชันกำหนดสีตามหมวดหมู่ (removed - kept placeholder in case needed later)

  // Widget สำหรับไอคอนการแจ้งเตือนพร้อมจุดแดง
  Widget _buildNotificationIcon() {
    return Stack(
      children: [
        const Icon(Icons.notifications),
        if (_unreadNotificationCount > 0)
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1),
              ),
            ),
          ),
      ],
    );
  }

  

  @override
  Widget build(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // ชื่อหน้าตาม tab ที่เลือก
    String getPageName() {
      switch (_selectedIndex) {
        case 0:
          return 'หน้าแรก';
        case 1:
          return 'แจ้งซ่อม';
        case 2:
          return 'รายการ';
        default:
          return 'หน้าแรก';
      }
    }
    
    return Scaffold(
      drawer: AppDrawer(
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      appBar: AppBar(
        title: Text(
          getPageName(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? Colors.lightBlueAccent : Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: _buildNotificationIcon(),
            tooltip: 'Notifications',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage(),
                ),
              ).then((_) {
                // อัพเดทจำนวนการแจ้งเตือนหลังจากกลับมาจากหน้า notification
                setState(() {
                  _unreadNotificationCount = 0; // จำลองการอ่านแจ้งเตือนทั้งหมด
                });
              });
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // หน้าแรก
          Container(
            // Ensure the background gradient covers the full screen height
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            decoration: isDark
                ? const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF232526), Color(0xFF414345)],
                    ),
                  )
                : const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      // Use two light-blue tones so it doesn't turn white at the bottom
                      colors: [Color(0xFFB0D0F0), Color(0xFFDCEBFA)],
                    ),
                  ),
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  // Home page simplified per request - no lists shown
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.home, size: 56, color: isDark ? Colors.white70 : Colors.blueAccent),
                        const SizedBox(height: 12),
                        Text(
                          'หน้าแรก',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'ไม่มีรายการแสดง',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
          // หน้าแจ้งซ่อม
          const AddPage(),
          // หน้ารายการ
          const ListPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF232526) : const Color(0xFFE3F2FD),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'หน้าแรก',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'รายการ',
              ),
            ],
            currentIndex: _selectedIndex == 2 ? 1 : _selectedIndex,
            selectedItemColor: isDark ? Colors.lightBlueAccent : Colors.blue,
            unselectedItemColor: isDark ? Colors.white54 : Colors.black54,
            backgroundColor: Colors.transparent,
            elevation: 0,
            onTap: _onItemTapped,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage()),
          );
        },
        backgroundColor: isDark ? Colors.lightBlueAccent : Colors.blue,
        foregroundColor: Colors.white,
        elevation: 8,
        shape: const CircleBorder(),
        child: const Icon(Icons.build, size: 28),
        tooltip: 'แจ้งซ่อม',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}