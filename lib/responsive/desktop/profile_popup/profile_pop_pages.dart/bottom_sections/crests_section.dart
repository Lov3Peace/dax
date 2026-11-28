import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/util/providers/profileSocketIoProvider.dart';

class PCCrests extends StatelessWidget {
  const PCCrests({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>().profile;

    final crests = List<String>.from(
      profile?['profile']?['crests'] ?? [],
    );

    return Container(
      height: 20.h(context),
      width: 18.w(context),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Crests',
              style: TextStyle(
                fontSize: 3.25.sp(context),
                color: Colors.white,
              ),
            ),
            SizedBox(height: 3.h(context)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: crests.map((crest) {
                  return Column(
                    children: [
                      Image.asset(
                        'images/$crest.png',
                        height: 9.h(context),
                        width: 5.5.w(context),
                        fit: BoxFit.contain,
                      ),
                      Text(
                        crest,
                        style: TextStyle(
                          fontSize: 2.5.sp(context),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
