// import 'package:flutter/material.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('BoostBuddy'),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           const Text(
//             'Settings',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           SwitchListTile(
//             title: const Text('Enable Notifications'),
//             value: true, // Replace with a stateful variable if needed
//             onChanged: (bool value) {
//               // Add functionality here
//             },
//           ),
//           ListTile(
//             title: const Text('Change Theme Color'),
//             onTap: () {
//               // Add functionality here
//             },
//           ),
//           ListTile(
//             title: const Text('Manage Account'),
//             onTap: () {
//               // Add functionality here
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: const Text(
          'Settings will go here!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
