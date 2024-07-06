import 'package:connecthub/pages/signing%20in_up/login_screen.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Account'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountSettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Advanced Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdvancedSettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Liked Services'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LikedServicesPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Invite Friends'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InviteFriendsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.support),
            title: const Text('Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SupportPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const About(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Log Out'),
            onTap: () {
              // Show a confirmation dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Log Out'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Implement log out functionality here
                        Navigator.pushNamed(context, 'Login');
                      },
                      child: const Text('Log Out'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Change Account'),
            onTap: () {
              // Navigate to a change account screen
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen(userData: {},)));
            },
          ),
        ],
      ),
    );
  }
}

class AdvancedSettingsPage extends StatelessWidget {
  const AdvancedSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Enable Dark Mode'),
            value: true, // Replace with actual dark mode setting
            onChanged: (value) {
              // Implement dark mode setting change
            },
          ),
          ListTile(
            title: const Text('Clear Cache'),
            onTap: () {
              // Implement clear cache functionality
            },
          ),
          ListTile(
            title: const Text('Data Usage'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DataUsagePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DataUsagePage extends StatelessWidget {
  const DataUsagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Usage'),
      ),
      body: ListView(
        children: const [
          // Add data usage information and settings
        ],
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Push Notifications'),
            value: true, // Replace with actual push notification setting
            onChanged: (value) {
              // Implement push notification setting change
            },
          ),
          ListTile(
            title: const Text('Notification Sounds'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationSoundsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NotificationSoundsPage extends StatelessWidget {
  const NotificationSoundsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Sounds'),
      ),
      body: ListView(
        children: const [
          // Add options to select notification sounds
        ],
      ),
    );
  }
}

class LikedServicesPage extends StatelessWidget {
  const LikedServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Services'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Service 1'),
            subtitle: const Text('Category: Category 1'),
            trailing: IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                // Implement unlike service functionality
              },
            ),
          ),
          ListTile(
            title: const Text('Service 2'),
            subtitle: const Text('Category: Category 2'),
            trailing: IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                // Implement unlike service functionality
              },
            ),
          ),
          // Add more liked services here
        ],
      ),
    );
  }
}

class InviteFriendsPage extends StatelessWidget {
  const InviteFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invite Friends'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Share App Link'),
            onTap: () {
              // Implement share app link functionality
            },
          ),
          ListTile(
            title: const Text('Connect to Social Media'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConnectSocialMediaPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ConnectSocialMediaPage extends StatelessWidget {
  const ConnectSocialMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect to Social Media'),
      ),
      body: ListView(
        children: const [
          // Add options to connect to social media accounts
        ],
      ),
    );
  }
}

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('FAQs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FaqsPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Contact Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactSupportPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FaqsPage extends StatelessWidget {
  const FaqsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: ListView(
        children: const [
          // Add a list of frequently asked questions and their answers
        ],
      ),
    );
  }
}

class ContactSupportPage extends StatelessWidget {
  const ContactSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Support'),
      ),
      body: ListView(
        children: const [
          // Add options to contact support (email, phone, chat, etc.)
        ],
      ),
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About ConnectHub'),
      ),
      body: const Text('ConnectHub is a revolutionary freelancing app designed to bring together skilled freelancers and clients in a seamless and efficient manner. In the ever-evolving gig economy, ConnectHub serves as a dynamic platform, fostering connections between freelancers and those seeking their expertise. Whether one is a talented professional looking for opportunities or a business in need of specialized services, ConnectHub is the go-to solution.'),
    );
  }
}
