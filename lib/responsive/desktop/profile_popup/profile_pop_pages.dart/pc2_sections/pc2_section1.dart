import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/carousel_contents_temp.dart';
import 'package:flutter_application_1/util/gradient_container.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../../main.dart';

class Pc2Section1 extends StatefulWidget {
  Pc2Section1({super.key});

  @override
  State<Pc2Section1> createState() => Pc2Section1State();
}

class Pc2Section1State extends State<Pc2Section1> {
  TextEditingController bioController = TextEditingController();
  Set<String> selectedSkills = {};
  // final Random random = Random();
  // final List<Map<String, dynamic>> availableButtons = List.generate(
  //     100,
  //     (index) => {
  //           "id": "btn$index",
  //           "label": [
  //             "Entrepreneurship",
  //             "Business Strategy",
  //             "Financial Literacy",
  //             "Marketing & Branding",
  //             "Sales Tactics",
  //             "Public Speaking",
  //             "Negotiation Skills",
  //             "Networking",
  //             "Customer Relationship Management",
  //             "Leadership & Team Management",
  //             "Problem Solving",
  //             "Time Management",
  //             "Critical Thinking",
  //             "Decision Making",
  //             "Creativity & Innovation",
  //             "Product Development",
  //             "Growth Hacking",
  //             "Social Media Marketing",
  //             "Content Creation",
  //             "SEO & Digital Marketing",
  //             "Copywriting",
  //             "E-commerce Management",
  //             "Crowdfunding & Fundraising",
  //             "Financial Planning & Budgeting",
  //             "Investment Strategies",
  //             "Legal Basics for Entrepreneurs",
  //             "Contract Negotiation",
  //             "Intellectual Property Management",
  //             "Risk Assessment",
  //             "Crisis Management",
  //             "Self-Discipline & Motivation",
  //             "Work-Life Balance",
  //             "Personal Branding",
  //             "Emotional Intelligence",
  //             "Project Management",
  //             "Bootstrapping & Lean Startup Methods",
  //             "Customer Service Excellence",
  //             "Data-Driven Decision Making",
  //             "Growth Mindset",
  //             "Tech-Savviness",
  //             "Remote Work Management",
  //             "Automation & AI Integration",
  //             "Freelancing & Gig Economy Skills",
  //             "Hobby Monetization",
  //             "DIY Skills",
  //             "Photography & Videography",
  //             "Graphic Design",
  //             "Web Design & Development",
  //             "Podcasting",
  //             "Event Planning",
  //             "Writing & Blogging",
  //             "Music Production",
  //             "Cooking & Culinary Arts",
  //             "Fitness & Personal Training",
  //             "Handcrafting & Artistry",
  //             "Woodworking & Metalworking",
  //             "Game Development",
  //             "3D Printing & Prototyping",
  //             "Fashion & Textile Design",
  //             "Tattoo Artistry",
  //             "Restoration & Upcycling",
  //             "Automotive Mechanics",
  //             "Home Improvement & Renovation",
  //             "Gardening & Sustainable Living",
  //             "Real Estate Investing",
  //             "Trading & Cryptocurrency",
  //             "Psychology & Persuasion",
  //             "Spiritual Growth & Mindfulness",
  //             "Survival Skills & Bushcraft",
  //             "Martial Arts & Self-Defense",
  //             "Drone Flying & Aerial Photography",
  //             "Storytelling & Screenwriting",
  //             "Language Learning & Translation",
  //             "Coaching & Mentoring",
  //             "Cybersecurity Awareness",
  //             "Influencer Marketing",
  //             "Livestreaming & Community Building",
  //             "Passive Income Strategies",
  //             "Public Relations",
  //             "Crowdsourcing & Open Innovation",
  //             "Consulting & Advisory Skills",
  //             "AI & Automation for Entrepreneurs",
  //             "Blockchain & Smart Contracts",
  //             "Sustainable Business Practices",
  //             "Ethical Business Leadership",
  //             "Import & Export Management",
  //             "Franchising & Licensing",
  //             "Subscription Business Models",
  //             "Psychological Pricing Strategies"
  //           ][index % 100]
  //         });

  // Color getRandomColor() {
  //   return Color.fromARGB(
  //     255,
  //     random.nextInt(256),
  //     random.nextInt(256),
  //     random.nextInt(256),
  //   );
  // }

  // final Map<String, List<Color>> buttonGradients = {};

  // List<Color> generateRandomGradient() {
  //   return [getRandomColor(), getRandomColor()];
  // }

  @override
  void initState() {
    super.initState();
    // for (var button in availableButtons) {
    //   buttonGradients[button["id"]] = generateRandomGradient();
    // }
    loadBio();
  }

  Future<void> loadBio() async {
    final prefs = await SharedPreferences.getInstance();
    bioController.text = prefs.getString('user_bio') ?? '';
    setState(() {});
  }

  Future<void> saveBio() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_bio', bioController.text.trim());
  }

  Future<void> loadSelectedSkills() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedSkills = prefs.getStringList('selected_skills')?.toSet() ?? {};
    });
  }

  Future<void> saveSelectedSkills() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('selected_skills', selectedSkills.toList());
  }

  // void showSkillsDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Select Skills"),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             children: availableButtons.map((skill) {
  //               return CheckboxListTile(
  //                 title: Text(skill["label"]),
  //                 value: selectedSkills.contains(skill["label"]),
  //                 onChanged: (bool? value) {
  //                   setState(() {
  //                     if (value == true) {
  //                       selectedSkills.add(skill["label"]);
  //                     } else {
  //                       selectedSkills.remove(skill["label"]);
  //                     }
  //                   });
  //                   Navigator.pop(context);
  //                 },
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return CarouselContentsTemp(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildBio(),
          buildSkills(),
        ],
      ),
    );
  }

  buildBio() {
    return Container(
      height: 21.5.h,
      width: 20.w,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 38, 42),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white70),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bio',
                style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: bioController,
                style: TextStyle(fontSize: 2.5.sp, color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Tell Us About Yourself!",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                maxLines: null, // Allows infinite lines
                keyboardType: TextInputType.multiline,
                onChanged: (text) => saveBio(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildSkills() {
    return Container(
      height: 21.5.h,
      width: 20.w,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 38, 42),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white70),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skills',
              style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 1.h,
            ),
            TactileButton(
              //             onTap: showSkillsDialog,
              child: GradientContainer(
                gradient1: red,
                gradient2: purp,
                height: 5,
                width: 20,
                neonGlow: purp,
                text: 'Select Skills',
                textSize: 2.5.sp,
                borderColor: const Color.fromARGB(0, 255, 255, 255),
                borderRadius: 500,
              ),
            )
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     selectedSkills.isEmpty
            //         ? TactileButton(
            //             onTap: showSkillsDialog,
            //             child: GradientContainer(
            //               gradient1: red,
            //               gradient2: purp,
            //               height: 5,
            //               width: 20,
            //               neonGlow: purp,
            //               text: 'Select Skills',
            //               textSize: 2.5.sp,
            //               borderColor: const Color.fromARGB(0, 255, 255, 255),
            //               borderRadius: 500,
            //             ),
            //           )
            //         : Wrap(
            //             spacing: 8,
            //             runSpacing: 8,
            //             children: selectedSkills.map((skill) {
            //               return TactileButton(
            //                 onTap: showSkillsDialog, // Opens selection modal
            //                 child: GradientContainer(
            //                   gradient1: buttonGradients[skill]?[0] ?? getRandomColor(),
            //                   gradient2: buttonGradients[skill]?[1] ?? getRandomColor(),
            //                   height: 5,
            //                   width: 20,
            //                   neonGlow: buttonGradients[skill]?[1] ?? getRandomColor(),
            //                   text: skill,
            //                   textSize: 2.5.sp,
            //                   borderColor: Colors.transparent,
            //                   borderRadius: 500,
            //                 ),
            //               );
            //             }).toList(),
            //           ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
