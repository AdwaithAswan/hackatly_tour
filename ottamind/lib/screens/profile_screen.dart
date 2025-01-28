import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Color(0xFFF0EA99)),
        ),
        backgroundColor: const Color(0xFF292929),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle logout
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFF24848D),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'User Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF0EA99),
                    ),
                  ),
                  const Text(
                    'user@email.com',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Travel Preferences Section
            const Text(
              'Travel Preferences',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF0EA99),
              ),
            ),
            const SizedBox(height: 16),
            
            // Preference Cards
            Card(
              color: const Color(0xFF4156A3),
              child: ListTile(
                leading: const Icon(Icons.attach_money, color: Color(0xFFF0EA99)),
                title: const Text('Budget Range'),
                subtitle: const Text('\$0 - \$1000'),
                onTap: () {
                  // Edit budget range
                },
              ),
            ),
            Card(
              color: const Color(0xFF4156A3),
              child: ListTile(
                leading: const Icon(Icons.restaurant, color: Color(0xFFF0EA99)),
                title: const Text('Food Preferences'),
                subtitle: const Text('All types'),
                onTap: () {
                  // Edit food preferences
                },
              ),
            ),
            Card(
              color: const Color(0xFF4156A3),
              child: ListTile(
                leading: const Icon(Icons.language, color: Color(0xFFF0EA99)),
                title: const Text('Language'),
                subtitle: const Text('English'),
                onTap: () {
                  // Edit language preference
                },
              ),
            ),

            const SizedBox(height: 32),

            // Settings Section
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF0EA99),
              ),
            ),
            const SizedBox(height: 16),
            
            Card(
              color: const Color(0xFF4156A3),
              child: ListTile(
                leading: const Icon(Icons.notifications, color: Color(0xFFF0EA99)),
                title: const Text('Notifications'),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {
                    // Handle notification toggle
                  },
                  activeColor: const Color(0xFF24848D),
                ),
              ),
            ),
            Card(
              color: const Color(0xFF4156A3),
              child: ListTile(
                leading: const Icon(Icons.security, color: Color(0xFFF0EA99)),
                title: const Text('Privacy Settings'),
                onTap: () {
                  // Navigate to privacy settings
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 