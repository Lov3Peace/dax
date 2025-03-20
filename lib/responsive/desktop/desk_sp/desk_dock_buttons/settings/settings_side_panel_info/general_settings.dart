import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

// The class the holds the information in the genral settings button
// note: There is much editing that needs to happen in these section but ultimately
// Ui must be created and better refined
class GeneralSettingsInfo extends StatelessWidget {
  GeneralSettingsInfo({super.key});

  final TextEditingController _textController = TextEditingController();
  bool _isEditingEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58.h(context),
      width: 47.w(context),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(17, 17, 17, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 2.h(context), left: 2.w(context)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 1.5.h(context)),
                child: const Text(
                  'General Settings',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36),
                ),
              ),

              // Container #1 which holds the Username access
              Padding(
                padding: EdgeInsets.only(bottom: 2.h(context)),
                child: Container(
                  height: 16.h(context),
                  width: 43.w(context),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(25, 25, 29, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 2.w(context),
                        ),
                        // This wrap contains the textfield and button that enables the editing of your username on the account
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 2.w(context),
                          children: [
                            const Text(
                              'Username:',
                            ),
                            SizedBox(
                              height: 10,
                              width: 25.w(context),
                              child: TextField(
                                controller: _textController,
                                enabled: _isEditingEnabled,
                                decoration: const InputDecoration(
                                  border: InputBorder.none, //removes bottom line
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _isEditingEnabled = !_isEditingEnabled;
                              },
                              child: Text(_isEditingEnabled ? 'Save' : 'Edit'),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        indent: 20,
                        endIndent: 20,
                        thickness: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 2.w(context),
                        ),
                        child: const Text(
                          'Placeholder',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Container #2
              Padding(
                padding: EdgeInsets.only(bottom: 2.h(context)),
                child: Container(
                  height: 16.h(context),
                  width: 43.w(context),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(25, 25, 29, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),

              //Container #3
              Padding(
                padding: EdgeInsets.only(bottom: 2.h(context)),
                child: Container(
                  height: 40.h(context),
                  width: 43.w(context),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(25, 25, 29, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
