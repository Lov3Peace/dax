import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PCProjects extends StatefulWidget {
  PCProjects({super.key});

  @override
  State<PCProjects> createState() => _PCProjectsState();
}

class _PCProjectsState extends State<PCProjects> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 18.w,
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
            style: TextStyle(fontSize: 3.25.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class PCTeams extends StatefulWidget {
  PCTeams({super.key});

  @override
  State<PCTeams> createState() => _PCTeamsState();
}

class _PCTeamsState extends State<PCTeams> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 18.w,
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
            style: TextStyle(fontSize: 3.25.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
