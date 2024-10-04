import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:sizer/sizer.dart';

class ProfileCardOne extends StatelessWidget {
  const ProfileCardOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            "images/creator.png",
            height: 18.w,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Creator',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(
          color: Colors.white,
          endIndent: 150,
          indent: 150,
          thickness: 0.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitlesSection(),
            _buildCrestsSection(),
            _buildProjectsSection(),
          ],
        ),
      ],
    );
  }

  Widget _buildTitlesSection() {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(0, 214, 206, 206),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      constraints: BoxConstraints(maxWidth: 17.w),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Titles',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 0.25.h),
            Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: _buildTitleButton(
                title: 'Creator',
                icon: Icons.create,
                gradientStartColor: const Color.fromARGB(245, 226, 22, 175), // Starting color of the gradient
                gradientEndColor: const Color.fromARGB(255, 235, 153, 237), // Ending color of the gradient // More vibrant pink
                maxWidth: 6.w,
              ),
            ),
            SizedBox(height: 0.25.h),
            Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: _buildTitleButton(
                title: 'Project Manager',
                icon: Icons.note_add,
                gradientStartColor: const Color.fromARGB(255, 172, 22, 226), // More vibrant pink
                gradientEndColor: const Color.fromARGB(255, 172, 22, 226),
                maxWidth: 9.5.w,
              ),
            ),
            SizedBox(height: 0.25.h),
            Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: _buildTitleButton(
                title: 'Developer',
                icon: Icons.keyboard,
                gradientStartColor: const Color.fromARGB(245, 4, 163, 242), // Replace with your desired border color
                gradientEndColor: const Color.fromARGB(245, 4, 163, 242), // Replace with your desired border color
                maxWidth: 7.w,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleButton({
    required String title,
    required IconData icon,
    required Color gradientStartColor,
    required Color gradientEndColor,
    required double maxWidth,
  }) {
    return TactileButton(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStartColor, gradientEndColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Add a shadow for depth
              blurRadius: 6,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon, size: 12, color: Colors.white70),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCrestsSection() {
    return Container(
      height: 15.h,
      decoration: const BoxDecoration(
        color: Color.fromARGB(0, 214, 206, 206),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      constraints: BoxConstraints(maxWidth: 17.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Crests',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 0.75.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCrestImage('images/creator.png'),
              _buildCrestImage('images/master.png'),
              _buildCrestImage('images/diamond.png'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCrestImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath,
        height: 4.5.w,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildProjectsSection() {
    return Container(
      height: 12.h,
      width: 17.w,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(149, 149, 215, 0),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      constraints: BoxConstraints(maxWidth: 17.w),
      child: const Column(
        children: [
          Text(
            'Projects',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
