// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../../../main.dart';
// import '../../../../../../util/gradient_container.dart';
// import '../../../../../../util/tactile_button.dart';

// class SecurityUi extends StatelessWidget {
//   // Load saved preferences
//   Future<Map<String, bool>> _loadPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool mfaEnabled = prefs.getBool('mfaEnabled') ?? false;
//     bool privateAccountEnabled = prefs.getBool('privateAccountEnabled') ?? false;

//     return {
//       'mfaEnabled': mfaEnabled,
//       'privateAccountEnabled': privateAccountEnabled,
//     };
//   }

//   // Save preference to SharedPreferences
//   Future<void> _savePreference(String key, dynamic value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (value is bool) {
//       await prefs.setBool(key, value);
//     } else if (value is String) {
//       await prefs.setString(key, value);
//     }
//   }

//   // Function to reset the password (for example purposes)
//   void _resetPassword(BuildContext context) {
//     final snackBar = const SnackBar(content: Text('Password reset! New password: NewPassword123'));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   // Function to edit recovery phone (for example purposes)
//   void _editRecoveryPhone(BuildContext context) {
//     final snackBar = const SnackBar(content: Text('Recovery phone updated!'));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, bool>>(
//       future: _loadPreferences(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         // Loaded values
//         bool mfaEnabled = snapshot.data!['mfaEnabled']!;
//         bool privateAccountEnabled = snapshot.data!['privateAccountEnabled']!;
//         final recoveryPhone = snapshot.data!['recoveryPhone'];

//         TextEditingController _phoneController = TextEditingController(text: 'recoveryPhone');

//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const Text(
//                 'Security',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // First Row: Password
//               const Text(
//                 'Password',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Color.fromARGB(136, 252, 251, 251),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('********'),
//                     TactileButton(
//                       onTap: () => _resetPassword(context),
//                       child: GradientContainer(
//                         gradient1: red,
//                         gradient2: purp,
//                         height: 5,
//                         width: 20,
//                         neonGlow: purp,
//                         text: 'Reset',
//                         textSize: 12,
//                         borderColor: const Color.fromARGB(0, 255, 255, 255),
//                         borderRadius: 500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // MFA Switch
//               SwitchListTile(
//                 title: const Text('MFA'),
//                 value: mfaEnabled,
//                 onChanged: (bool value) async {
//                   await _savePreference('mfaEnabled', value);
//                   (context as Element).markNeedsBuild(); // Rebuild the widget to reflect changes
//                 },
//               ),

//               const Divider(
//                 endIndent: 10,
//                 indent: 10,
//                 color: Color.fromARGB(168, 255, 255, 255),
//               ),
//               // Second Row: Recovery Phone
//               const Text(
//                 'Recovery Phone',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Color.fromARGB(136, 252, 251, 251),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     width: 150,
//                     child: TextField(
//                       controller: _phoneController,
//                       onChanged: (value) {
//                         _savePreference('recoveryPhone', value); // Save on change
//                       },
//                       decoration: const InputDecoration(
//                         hintText: 'Enter phone',
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   TactileButton(
//                     onTap: () => _editRecoveryPhone(context),
//                     child: GradientContainer(
//                       gradient1: red,
//                       gradient2: purp,
//                       height: 5,
//                       width: 20,
//                       neonGlow: purp,
//                       text: 'Update',
//                       textSize: 12,
//                       borderColor: const Color.fromARGB(0, 255, 255, 255),
//                       borderRadius: 500,
//                     ),
//                   ),
//                 ],
//               ),

//               const Divider(
//                 endIndent: 10,
//                 indent: 10,
//                 color: Color.fromARGB(168, 255, 255, 255),
//               ),

//               // Privacy Switch
//               const Text(
//                 'Privacy',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Color.fromARGB(136, 252, 251, 251),
//                 ),
//               ),
//               SwitchListTile(
//                 title: const Text('Private Account'),
//                 value: privateAccountEnabled,
//                 onChanged: (bool value) async {
//                   await _savePreference('privateAccountEnabled', value);
//                   (context as Element).markNeedsBuild(); // Rebuild the widget to reflect changes
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../main.dart';
import '../../../../../../util/gradient_container.dart';
import '../../../../../../util/tactile_button.dart';

class SecurityUi extends StatelessWidget {
  // Load saved preferences
  Future<Map<String, dynamic>> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'mfaEnabled': prefs.getBool('mfaEnabled') ?? false,
      'privateAccountEnabled': prefs.getBool('privateAccountEnabled') ?? false,
      'recoveryPhone': prefs.getString('recoveryPhone') ?? '',
    };
  }

  // Save preference to SharedPreferences
  Future<void> _savePreference(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  // Show snackbars for different actions
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Function to reset the password
  void _resetPassword(BuildContext context) {
    _showSnackBar(context, 'Password reset! New password: NewPassword123');
  }

  // Function to edit recovery phone
  void _editRecoveryPhone(BuildContext context) {
    _showSnackBar(context, 'Recovery phone updated!');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadPreferences(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final bool mfaEnabled = snapshot.data!['mfaEnabled']!;
        final bool privateAccountEnabled = snapshot.data!['privateAccountEnabled']!;
        final String recoveryPhone = snapshot.data!['recoveryPhone'];

        TextEditingController _phoneController = TextEditingController(text: recoveryPhone);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Security',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Password Section
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(136, 252, 251, 251),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('********'),
                    TactileButton(
                      onTap: () => _resetPassword(context),
                      child: GradientContainer(
                        gradient1: red,
                        gradient2: purp,
                        height: 5,
                        width: 20,
                        neonGlow: purp,
                        text: 'Reset',
                        textSize: 12,
                        borderColor: Colors.transparent,
                        borderRadius: 500,
                      ),
                    ),
                  ],
                ),
              ),

              // MFA Toggle with StatefulBuilder for immediate switch response
              StatefulBuilder(
                builder: (context, setState) {
                  return SwitchListTile(
                    title: const Text('MFA'),
                    value: mfaEnabled,
                    onChanged: (bool value) async {
                      setState(() {
                        _savePreference('mfaEnabled', value);
                      });
                    },
                  );
                },
              ),

              const Divider(color: Color.fromARGB(168, 255, 255, 255)),

              // Recovery Phone Section
              const Text(
                'Recovery Phone',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(136, 252, 251, 251),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: _phoneController,
                      onChanged: (value) {
                        _savePreference('recoveryPhone', value); // Save on change
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter phone',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  TactileButton(
                    onTap: () => _editRecoveryPhone(context),
                    child: GradientContainer(
                      gradient1: red,
                      gradient2: purp,
                      height: 5,
                      width: 20,
                      neonGlow: purp,
                      text: 'Update',
                      textSize: 12,
                      borderColor: Colors.transparent,
                      borderRadius: 500,
                    ),
                  ),
                ],
              ),

              const Divider(color: Color.fromARGB(168, 255, 255, 255)),

              // Privacy Toggle with StatefulBuilder for immediate switch response
              StatefulBuilder(
                builder: (context, setState) {
                  return SwitchListTile(
                    title: const Text('Private Account'),
                    value: privateAccountEnabled,
                    onChanged: (bool value) async {
                      setState(() {
                        _savePreference('privateAccountEnabled', value);
                      });
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
