// import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../../../main.dart';
// import '../../../../../../util/gradient_container.dart';
// import '../../../../../../util/tactile_button.dart';

// class GeneralUi extends StatelessWidget {
//   // Load saved preferences
//   Future<Map<String, dynamic>> _loadPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return {
//       'username': prefs.getString('username') ?? '',
//       'email': prefs.getString('email') ?? '',
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

//   // Show snackbars for different actions
//   void _showSnackBar(BuildContext context, String message) {
//     final snackBar = SnackBar(content: Text(message));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   // Function to edit recovery phone
//   void _editUsername(BuildContext context) {
//     _showSnackBar(context, 'Username updated!');
//   }

//   // Function to edit recovery phone
//   void _editEmail(BuildContext context) {
//     _showSnackBar(context, 'Email updated!');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, dynamic>>(
//       future: _loadPreferences(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final String username = snapshot.data!['username'];
//         final String email = snapshot.data!['email'];

//         TextEditingController _usernameController = TextEditingController(text: 'usernameControl');
//         TextEditingController _emailController = TextEditingController(text: 'emailControl');

//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const Text(
//                 'General',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Password Section
//               const Text(
//                 'Username',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Color.fromARGB(136, 252, 251, 251),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SizedBox(
//                     width: 150,
//                     child: TextField(
//                       controller: _usernameController,
//                       onChanged: (value) {
//                         _savePreference('recoveryPhone', value); // Save on change
//                       },
//                       decoration: const InputDecoration(
//                         hintText: 'Username',
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   TactileButton(
//                     onTap: () => _editUsername(context),
//                     child: GradientContainer(
//                       gradient1: red,
//                       gradient2: purp,
//                       height: 5,
//                       width: 20,
//                       neonGlow: purp,
//                       text: 'Update',
//                       textSize: 12,
//                       borderColor: Colors.transparent,
//                       borderRadius: 500,
//                     ),
//                   ),
//                 ],
//               ),

//               const Divider(color: Color.fromARGB(168, 255, 255, 255)),

//               // Recovery Phone Section
//               const Text(
//                 'Email',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Color.fromARGB(136, 252, 251, 251),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SizedBox(
//                     width: 150,
//                     child: TextField(
//                       controller: _emailController,
//                       onChanged: (value) {
//                         _savePreference('recoveryPhone', value); // Save on change
//                       },
//                       decoration: const InputDecoration(
//                         hintText: 'Enter Email',
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   TactileButton(
//                     onTap: () => _editEmail(context),
//                     child: GradientContainer(
//                       gradient1: red,
//                       gradient2: purp,
//                       height: 5,
//                       width: 20,
//                       neonGlow: purp,
//                       text: 'Email',
//                       textSize: 12,
//                       borderColor: Colors.transparent,
//                       borderRadius: 500,
//                     ),
//                   ),
//                 ],
//               ),

//               const Divider(color: Color.fromARGB(168, 255, 255, 255)),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../main.dart';
import '../../../../../../util/gradient_container.dart';
import '../../../../../../util/tactile_button.dart';
import 'general_bloc.dart';
// Import your LocationCubit

class GeneralUi extends StatelessWidget {
  // Load saved preferences
  Future<Map<String, dynamic>> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString('username') ?? '',
      'email': prefs.getString('email') ?? '',
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

  // Function to edit recovery phone
  void _editUsername(BuildContext context) {
    _showSnackBar(context, 'Username updated!');
  }

  // Function to edit recovery phone
  void _editEmail(BuildContext context) {
    _showSnackBar(context, 'Email updated!');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadPreferences(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final String username = snapshot.data!['username'];
        final String email = snapshot.data!['email'];

        TextEditingController _usernameController = TextEditingController(text: username);
        TextEditingController _emailController = TextEditingController(text: email);

        return BlocProvider(
          create: (context) => LocationBloc(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'General',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Username Section
                const Text(
                  'Username',
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
                        controller: _usernameController,
                        onChanged: (value) {
                          _savePreference('username', value); // Save on change
                        },
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TactileButton(
                      onTap: () => _editUsername(context),
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

                // Email Section
                const Text(
                  'Email',
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
                        controller: _emailController,
                        onChanged: (value) {
                          _savePreference('email', value); // Save on change
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter Email',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TactileButton(
                      onTap: () => _editEmail(context),
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

                // Email Section
                const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(136, 252, 251, 251),
                  ),
                ),

                BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    if (state is LocationInitial) {
                      return TactileButton(
                        onTap: () => context.read<LocationBloc>().getLocation(),
                        child: GradientContainer(
                          gradient1: red,
                          gradient2: purp,
                          height: 5, // Adjust button height if needed
                          width: 20, // Adjust button width if needed
                          neonGlow: purp,
                          text: 'Access Location',
                          textSize: 16, // Adjust text size if needed
                          borderColor: Colors.transparent,
                          borderRadius: 500,
                        ),
                      );
                    } else if (state is LocationLoading) {
                      return const CircularProgressIndicator(); // Show a loading indicator while fetching location
                    } else if (state is LocationLoaded) {
                      return Text(state.address); // Display the human-readable address when loaded
                    } else if (state is LocationError) {
                      return Column(
                        children: [
                          Text(state.errorMessage), // Display error message
                          SizedBox(height: 20),
                          CircularProgressIndicator(), // Show a progress indicator before the button resets
                        ],
                      );
                    }
                    return Container(); // Return an empty container for other states
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
