// import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// /*

// THIS IS THE NOTIFICATION UI THAT IMPLEMENTS BLOC

// */

// class NotificationsColumn extends StatelessWidget {
//   final bool messagesEnabled;
//   final bool friendRequestsEnabled;
//   final bool transactionsEnabled;
//   final ValueChanged<bool> onMessagesChanged;
//   final ValueChanged<bool> onFriendRequestsChanged;
//   final ValueChanged<bool> onTransactionsChanged;

//   const NotificationsColumn({
//     super.key,
//     required this.messagesEnabled,
//     required this.friendRequestsEnabled,
//     required this.transactionsEnabled,
//     required this.onMessagesChanged,
//     required this.onFriendRequestsChanged,
//     required this.onTransactionsChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Notifications',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SwitchListTile(
//           title: const Text('Messages'),
//           value: messagesEnabled,
//           onChanged: onMessagesChanged,
//         ),
//         SwitchListTile(
//           title: const Text('Friend Requests'),
//           value: friendRequestsEnabled,
//           onChanged: onFriendRequestsChanged,
//         ),
//         SwitchListTile(
//           title: const Text('Transactions'),
//           value: transactionsEnabled,
//           onChanged: onTransactionsChanged,
//         ),
//       ],
//     );
//   }
// }

// class ParentWidget extends StatefulWidget {
//   const ParentWidget({super.key});

//   @override
//   _ParentWidgetState createState() => _ParentWidgetState();
// }

// class _ParentWidgetState extends State<ParentWidget> {
//   bool _messagesEnabled = false;
//   bool _friendRequestsEnabled = false;
//   bool _transactionsEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadPreferences();
//   }

//   // Load saved preferences
//   Future<void> _loadPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _messagesEnabled = prefs.getBool('messagesEnabled') ?? false;
//       _friendRequestsEnabled = prefs.getBool('friendRequestsEnabled') ?? false;
//       _transactionsEnabled = prefs.getBool('transactionsEnabled') ?? false;
//     });
//   }

//   // Save the state to SharedPreferences
//   Future<void> _savePreference(String key, bool value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(key, value);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: NotificationsColumn(
//         messagesEnabled: _messagesEnabled,
//         friendRequestsEnabled: _friendRequestsEnabled,
//         transactionsEnabled: _transactionsEnabled,
//         onMessagesChanged: (bool value) {
//           setState(() {
//             _messagesEnabled = value;
//           });
//           _savePreference('messagesEnabled', value);
//         },
//         onFriendRequestsChanged: (bool value) {
//           setState(() {
//             _friendRequestsEnabled = value;
//           });
//           _savePreference('friendRequestsEnabled', value);
//         },
//         onTransactionsChanged: (bool value) {
//           setState(() {
//             _transactionsEnabled = value;
//           });
//           _savePreference('transactionsEnabled', value);
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*

THIS IS THE NOTIFICATION UI THAT IMPLEMENTS BLOC 

*/

class NotificationsUi extends StatefulWidget {
  const NotificationsUi({super.key});

  @override
  _NotificationsUiState createState() => _NotificationsUiState();
}

class _NotificationsUiState extends State<NotificationsUi> {
  bool _messagesEnabled = false;
  bool _friendRequestsEnabled = false;
  bool _transactionsEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Load saved preferences
  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _messagesEnabled = prefs.getBool('messagesEnabled') ?? false;
      _friendRequestsEnabled = prefs.getBool('friendRequestsEnabled') ?? false;
      _transactionsEnabled = prefs.getBool('transactionsEnabled') ?? false;
    });
  }

  // Save the state to SharedPreferences
  Future<void> _savePreference(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SwitchListTile(
            title: const Text('Messages'),
            value: _messagesEnabled,
            onChanged: (bool value) {
              setState(() {
                _messagesEnabled = value;
              });
              _savePreference('messagesEnabled', value);
            },
          ),
          SwitchListTile(
            title: const Text('Friend Requests'),
            value: _friendRequestsEnabled,
            onChanged: (bool value) {
              setState(() {
                _friendRequestsEnabled = value;
              });
              _savePreference('friendRequestsEnabled', value);
            },
          ),
          SwitchListTile(
            title: const Text('Transactions'),
            value: _transactionsEnabled,
            onChanged: (bool value) {
              setState(() {
                _transactionsEnabled = value;
              });
              _savePreference('transactionsEnabled', value);
            },
          ),
        ],
      ),
    );
  }
}
