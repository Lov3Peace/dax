import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/gradient_container.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'skills_bloc.dart'; // Import your SkillsBloc class here

class SkillsUI extends StatelessWidget {
  // A comprehensive list of skills from multiple industries
  final List<String> skillsList = [
    // Technology
    'Programming', 'Data Analysis', 'Network Security', 'UI/UX Design', 'Cloud Computing',
    'Machine Learning', 'DevOps', 'Mobile Development', 'Web Development', 'Cybersecurity',
    // Finance
    'Financial Analysis', 'Budgeting', 'Accounting', 'Tax Preparation', 'Investment Strategy',
    'Auditing', 'Risk Management', 'Financial Reporting', 'Wealth Management', 'Portfolio Management',
    // Healthcare
    'Patient Care', 'Medical Coding', 'Surgery Assistance', 'Nursing', 'Medical Research',
    'Phlebotomy', 'Radiology', 'Physical Therapy', 'Emergency Response', 'Pharmacy',
    // Education
    'Curriculum Design', 'Classroom Management', 'Student Assessment', 'Lesson Planning',
    'Special Education', 'Educational Technology', 'Tutoring', 'E-learning Development',
    // Construction
    'Project Management', 'Blueprint Reading', 'Site Safety', 'Carpentry', 'Masonry',
    'Electrical Work', 'Plumbing', 'Welding', 'Heavy Equipment Operation', 'Surveying',
    // Business
    'Leadership', 'Teamwork', 'Sales', 'Marketing Strategy', 'Public Relations', 'Customer Service',
    'Negotiation', 'Contract Management', 'Business Development', 'Entrepreneurship',
    // Retail
    'Inventory Management', 'Cash Handling', 'Visual Merchandising', 'Sales Forecasting',
    'Customer Relationship Management', 'POS System', 'Supply Chain Management',
    // Hospitality
    'Event Planning', 'Food Safety', 'Housekeeping', 'Bartending', 'Catering', 'Concierge Services',
    'Hotel Management', 'Menu Design', 'Waitstaff Service', 'Tourism Management',
    // Logistics & Transportation
    'Supply Chain Management', 'Freight Coordination', 'Warehousing', 'Fleet Management',
    'Shipping', 'Logistics Strategy', 'Customs Compliance', 'Route Planning', 'Inventory Control',
    // Legal
    'Legal Research', 'Contract Review', 'Litigation', 'Compliance', 'Intellectual Property Law',
    'Corporate Law', 'Employment Law', 'Criminal Law', 'Case Management', 'Paralegal Work',
    // Other industries
    'Agriculture', 'Journalism', 'Graphic Design', 'Photography', 'Video Editing', 'Writing',
    'Real Estate', 'HR Management', 'Data Entry', 'Quality Assurance', 'Manufacturing',
    'Translation', 'Copywriting', 'SEO', 'Interior Design'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SkillsBloc(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skills',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<SkillsBloc, List<String>>(
                builder: (context, skills) {
                  return ListView.builder(
                    itemCount: skills.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              skills[index],
                              style: TextStyle(fontSize: 18),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                BlocProvider.of<SkillsBloc>(context).removeSkill(index);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: TactileButton(
                onTap: () => {_showSelectSkillDialog(context)},
                child: GradientContainer(
                  gradient1: red,
                  gradient2: purp,
                  height: 5,
                  width: 20,
                  neonGlow: purp,
                  text: 'Add Skills',
                  textSize: 12,
                  borderColor: const Color.fromARGB(0, 255, 255, 255),
                  borderRadius: 500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show a dialog with a list of selectable skills
  void _showSelectSkillDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Skills'),
          content: SingleChildScrollView(
            child: Column(
              children: skillsList.map((skill) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(9, 238, 238, 238),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        skill,
                        style: TextStyle(fontSize: 18),
                      ),
                      TactileButton(
                        onTap: () {
                          BlocProvider.of<SkillsBloc>(context).addSkill(skill);
                          Navigator.of(context).pop();
                        },
                        child: GradientContainer(
                          gradient1: red,
                          gradient2: purp,
                          height: 5,
                          width: 20,
                          neonGlow: purp,
                          text: 'Add',
                          textSize: 12,
                          borderColor: const Color.fromARGB(0, 255, 255, 255),
                          borderRadius: 500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TactileButton(
              onTap: () => Navigator.of(context).pop(),
              child: GradientContainer(
                gradient1: red,
                gradient2: purp,
                height: 5,
                width: 20,
                neonGlow: purp,
                text: 'Close',
                textSize: 12,
                borderColor: const Color.fromARGB(0, 255, 255, 255),
                borderRadius: 500,
              ),
            ),
          ],
        );
      },
    );
  }
}
