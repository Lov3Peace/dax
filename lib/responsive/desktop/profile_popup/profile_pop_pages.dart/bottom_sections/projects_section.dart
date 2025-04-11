import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

class PCProjects extends StatefulWidget {
  PCProjects({super.key});

  @override
  State<PCProjects> createState() => PCProjectsState();
}

class PCProjectsState extends State<PCProjects> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h(context),
      width: 18.w(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(0, 34, 38, 42),
        borderRadius: BorderRadius.circular(30),
        // border: Border.all(color: Colors.white70),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Projects',
            style: TextStyle(fontSize: 3.25.sp(context), color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class PCTeams extends StatefulWidget {
  PCTeams({super.key});

  @override
  State<PCTeams> createState() => PCTeamsState();
}

class PCTeamsState extends State<PCTeams> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h(context),
      width: 18.w(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(0, 34, 38, 42),
        borderRadius: BorderRadius.circular(30),
        // border: Border.all(color: Colors.white70),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Teams',
            style: TextStyle(fontSize: 3.25.sp(context), color: Colors.white),
          ),
        ],
      ),
    );
  }
}
