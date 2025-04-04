// import 'dart:ui';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
// import 'package:flutter_application_1/main.dart';
// import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_1/pcone_ui.dart';
// import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_2/pctwo_ui.dart';
// import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_3/pcthree_ui.dart';
// import 'package:flutter_application_1/util/auth/login.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:supercharged/supercharged.dart';
// import '../../../util/tactile_button.dart';
// import '../desk_sp/desk_dock_buttons/connections/desk_profile_circle.dart';
// import 'desk_profile_popup_cubit.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// final profileBucket = PageStorageBucket();

// class ProfilePopup extends StatefulWidget {
//   const ProfilePopup({super.key});

//   @override
//   State<ProfilePopup> createState() => _ProfilePopupState();
// }

// class _ProfilePopupState extends State<ProfilePopup> {
//   int _currentIndex = 0;

//   final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => ProfileBloc(),
//       child: Center(
//         child: Padding(
//           padding: EdgeInsets.only(bottom: 10.h(context), top: 4.h(context)),
//           child: Container(
//             height: 80.h(context),
//             width: 60.w(context),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(32),
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
//             child: Material(
//               shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
//               color: const Color.fromARGB(42, 55, 52, 52),
//               elevation: 2,
//               borderRadius: BorderRadius.circular(32),
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(24),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                       child: Container(
//                         height: 85.h(context),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: const Color.fromARGB(182, 31, 31, 31)),
//                           borderRadius: BorderRadius.circular(24),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(
//                             right: 1.w(context),
//                             left: 1.w(context),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               _buildTactileButton(context),
//                               Center(
//                                 child: AnimatedSmoothIndicator(
//                                   activeIndex: _currentIndex,
//                                   count: 3, // Number of items
//                                   effect: const ExpandingDotsEffect(
//                                     dotHeight: 10,
//                                     dotWidth: 10,
//                                     activeDotColor: red,
//                                     dotColor: Colors.grey,
//                                   ),
//                                 ),
//                               ),
//                               _buildContainer(),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 2.h(context),
//                         ),
//                         Listener(
//                           child: CarouselSlider.builder(
//                             itemCount: 3, // Number of items
//                             options: CarouselOptions(
//                               height: 45.h(context), // Adjust height as necessary
//                               viewportFraction: 1.0, // Each item takes full width
//                               onPageChanged: (index, reason) {
//                                 setState(() {
//                                   _currentIndex = index;
//                                 });
//                               },
//                             ),
//                             itemBuilder: (context, index, realIndex) {
//                               return AnimatedOpacity(
//                                 opacity: _currentIndex == index ? 1.0 : 0.0,
//                                 duration: const Duration(milliseconds: 800), // Adjust fade duration
//                                 curve: Curves.easeInOut, // Smooth transition curve
//                                 child: _buildCarouselItem(index),
//                               );
//                             },
//                           ),
//                         ),
//                         const Divider(
//                           color: Colors.white,
//                           endIndent: 150,
//                           indent: 150,
//                           thickness: 0.5,
//                         ),
//                         SizedBox(
//                           height: 2.h(context),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             right: 1.w(context),
//                             left: 1.w(context),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               _buildTitlesSection(),
//                               _buildCrestsSection(),
//                               _buildProjectsSection(),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCarouselItem(int index) {
//     if (index == 0) {
//       return const PC1();
//     } else if (index == 1) {
//       return PC2();
//     } else {
//       return const PC3();
//     }
//   }

//   Widget _buildTactileButton(context) {
//     return TactileButton(
//       onTap: () {
//         Navigator.pop(context); // This will close the popup
//       },
//       child: Container(
//         width: 9.w(context),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: const Color.fromARGB(136, 134, 143, 151), // Replace with your desired border color
//             // Adjust the border width as needed
//           ),
//           borderRadius: BorderRadius.circular(32), // Optional: to give rounded corners
//         ),
//         constraints: BoxConstraints(
//           maxWidth: 9.w(context),
//         ),
//         // Adjust padding as needed
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             // Adds a forward arrow icon
//             const ProfileCircle(),

//             Text(
//               auth.currentUser!.email.toString().allBefore('@'),
//               style: GoogleFonts.montserrat(
//                 textStyle: const TextStyle(fontSize: 16, height: 1.0),
//                 fontWeight: FontWeight.w600,
//               ),
//               textAlign: TextAlign.left, // Aligns text to the left within the row
//               overflow: TextOverflow.ellipsis, // Handles overflow by adding '...' if the text is too long
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildContainer() {
//     return Container(
//       height: 5.h(context),
//       width: 10.w(context),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: const Color.fromARGB(136, 134, 143, 151), // Replace with your desired border color
//           // Adjust the border width as needed
//         ),
//         borderRadius: BorderRadius.circular(32), // Optional: to give rounded corners
//       ),
//       child: const Row(
//         children: [],
//       ),
//     );
//   }

//   Widget _buildTitlesSection() {
//     return BlocBuilder<ProfileBloc, ProfileState>(
//       builder: (context, state) {
//         if (state is TitlesUpdated) {
//           return Column(
//             children: state.titles
//                 .map((title) => Text(
//                       title,
//                       style: const TextStyle(color: Colors.white),
//                     ))
//                 .toList(growable: true),
//           );
//         }
//         return const Text('Loading titles...');
//       },
//     );
//   }

//   Widget _buildCrestsSection() {
//     return BlocBuilder<ProfileBloc, ProfileState>(
//       builder: (context, state) {
//         if (state is CrestsUpdated) {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: state.crests.map((crest) => _buildCrestImage(crest)).toList(),
//           );
//         }
//         return const Text('Loading crests...');
//       },
//     );
//   }

//   Widget _buildCrestImage(String imagePath) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(16),
//       child: Image.asset(
//         imagePath,
//         height: 4.5.w(context),
//         fit: BoxFit.cover,
//       ),
//     );
//   }

//   Widget _buildProjectsSection() {
//     return BlocBuilder<ProfileBloc, ProfileState>(
//       builder: (context, state) {
//         if (state is ProjectsUpdated) {
//           return Column(
//             children: state.projects
//                 .map((project) => Text(
//                       project,
//                       style: const TextStyle(color: Colors.white),
//                     ))
//                 .toList(),
//           );
//         }
//         return const Text('Loading projects...');
//       },
//     );
//   }
// }
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_1/pcone_ui.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_2/pctwo_ui.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_3/pcthree_ui.dart';
import 'package:flutter_application_1/util/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';
import '../../../util/tactile_button.dart';
import '../desk_sp/desk_dock_buttons/connections/desk_profile_circle.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ProfileNotifier class for state management
class ProfileNotifier extends ChangeNotifier {
  int _currentIndex = 0;
  List<String> titles = ['Developer', 'Designer', 'Manager'];
  List<String> crests = ['images/creator.png', 'images/master.png', 'images/diamond.png'];
  List<String> projects = ['Project A', 'Project B', 'Project C'];

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

// ProfilePopup UI
class ProfilePopup extends StatefulWidget {
  ProfilePopup({super.key});

  @override
  State<ProfilePopup> createState() => _ProfilePopupState();
}

class _ProfilePopupState extends State<ProfilePopup> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileNotifier(),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 8.h(context), top: 3.h(context)),
          child: Container(
            height: 80.h(context),
            width: 60.w(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
            ),
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Material(
              shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
              color: const Color.fromARGB(42, 55, 52, 52),
              elevation: 2,
              borderRadius: BorderRadius.circular(32),
              child: Stack(
                children: [
                  _buildBackgroundBlur(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _buildTopRow(context),
                        SizedBox(height: 1.h(context)),
                        _buildCarousel(),
                        Divider(color: Colors.white, endIndent: 150, indent: 150, thickness: 0.5),
                        SizedBox(height: 1.h(context)),
                        _buildInfoSections(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundBlur() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 85.h(context),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(182, 31, 31, 31)),
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTactileButton(context),
          Consumer<ProfileNotifier>(
            builder: (context, notifier, child) {
              return AnimatedSmoothIndicator(
                activeIndex: notifier.currentIndex,
                count: 3,
                effect: const ExpandingDotsEffect(dotHeight: 10, dotWidth: 10, activeDotColor: Colors.red, dotColor: Colors.grey),
              );
            },
          ),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return Consumer<ProfileNotifier>(
      builder: (context, notifier, child) {
        return CarouselSlider.builder(
          itemCount: 3,
          options: CarouselOptions(
            height: 45.h(context),
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              notifier.updateIndex(index);
            },
          ),
          itemBuilder: (context, index, realIndex) => AnimatedOpacity(
            opacity: notifier.currentIndex == index ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            child: _buildCarouselItem(index),
          ),
        );
      },
    );
  }

  Widget _buildCarouselItem(int index) {
    switch (index) {
      case 0:
        return PC1();
      case 1:
        return PC2();
      case 2:
      default:
        return PC3();
    }
  }

  Widget _buildTactileButton(BuildContext context) {
    return TactileButton(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 9.w(context),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(136, 134, 143, 151)),
          borderRadius: BorderRadius.circular(32),
        ),
        constraints: BoxConstraints(maxWidth: 9.w(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ProfileCircle(),
            Text(
              auth.currentUser!.email.toString().allBefore('@'),
              style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, height: 1.0),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Container(
      height: 5.h(context),
      width: 10.w(context),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(136, 134, 143, 151)),
        borderRadius: BorderRadius.circular(32),
      ),
    );
  }

  Widget _buildInfoSections() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w(context)),
      child: Consumer<ProfileNotifier>(
        builder: (context, notifier, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSection(notifier.titles.map((title) => _buildTitleButton(title)).toList()),
              _buildSection(notifier.crests.map((crest) => _buildCrestImage(crest)).toList(), horizontal: true),
              _buildSection(notifier.projects.map((project) => _buildProjectText(project)).toList()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(List<Widget> items, {bool horizontal = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text(
        //   title,
        //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        // ),
        SizedBox(height: 0.5.h(context)),
        horizontal
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: items,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: items,
              ),
      ],
    );
  }

  Widget _buildTitleButton(String title) {
    final gradientColors = [
      [Colors.purple, Colors.blue],
      [Colors.orange, Colors.red],
      [Colors.green, Colors.teal],
    ];
    final gradient = gradientColors[title.hashCode % gradientColors.length];

    return TactileButton(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withOpacity(0.6),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildCrestImage(String imagePath) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(imagePath, height: 4.5.w(context), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildProjectText(String project) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        project,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
