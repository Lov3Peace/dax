import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_1/pcone_ui.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_2/pctwo_ui.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/profile_card_3/pcthree_ui.dart';
import 'package:flutter_application_1/util/auth/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:supercharged/supercharged.dart';
import '../../../util/tactile_button.dart';
import '../desk_sp/desk_dock_buttons/connections/desk_profile_circle.dart';
import 'desk_profile_popup_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final profileBucket = PageStorageBucket();

class ProfilePopup extends StatefulWidget {
  ProfilePopup({super.key});

  @override
  State<ProfilePopup> createState() => _ProfilePopupState();
}

class _ProfilePopupState extends State<ProfilePopup> {
  final CarouselController _controller = CarouselController();

  int _currentIndex = 0;

  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h, top: 4.h),
          child: Container(
            height: 80.h,
            width: 60.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
            ),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Material(
              shadowColor: const Color.fromRGBO(42, 41, 41, 0.631),
              color: const Color.fromARGB(42, 55, 52, 52),
              elevation: 2,
              borderRadius: BorderRadius.circular(32),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: 85.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(182, 31, 31, 31)),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 1.w,
                            left: 1.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildTactileButton(context),
                              Center(
                                child: AnimatedSmoothIndicator(
                                  activeIndex: _currentIndex,
                                  count: 3, // Number of items
                                  effect: const ExpandingDotsEffect(
                                    dotHeight: 10,
                                    dotWidth: 10,
                                    activeDotColor: red,
                                    dotColor: Colors.grey,
                                  ),
                                ),
                              ),
                              _buildContainer(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Listener(
                          child: CarouselSlider.builder(
                            itemCount: 3, // Number of items
                            options: CarouselOptions(
                              height: 45.h, // Adjust height as necessary
                              viewportFraction: 1.0, // Each item takes full width
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                            itemBuilder: (context, index, realIndex) {
                              return AnimatedOpacity(
                                opacity: _currentIndex == index ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 800), // Adjust fade duration
                                curve: Curves.easeInOut, // Smooth transition curve
                                child: _buildCarouselItem(index),
                              );
                            },
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                          endIndent: 150,
                          indent: 150,
                          thickness: 0.5,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 1.w,
                            left: 1.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildTitlesSection(),
                              _buildCrestsSection(),
                              _buildProjectsSection(),
                            ],
                          ),
                        ),
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

  Widget _buildCarouselItem(int index) {
    if (index == 0) {
      return PC1();
    } else if (index == 1) {
      return PC2();
    } else {
      return PC3();
    }
  }

  Widget _buildTactileButton(context) {
    return TactileButton(
      onTap: () {
        Navigator.pop(context); // This will close the popup
      },
      child: Container(
        width: 9.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(136, 134, 143, 151), // Replace with your desired border color
            // Adjust the border width as needed
          ),
          borderRadius: BorderRadius.circular(32), // Optional: to give rounded corners
        ),
        constraints: BoxConstraints(
          maxWidth: 9.w,
        ),
        // Adjust padding as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Adds a forward arrow icon
            const ProfileCircle(),

            Text(
              auth.currentUser!.email.toString().allBefore('@'),
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(fontSize: 16, height: 1.0),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left, // Aligns text to the left within the row
              overflow: TextOverflow.ellipsis, // Handles overflow by adding '...' if the text is too long
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Container(
      height: 5.h,
      width: 10.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(136, 134, 143, 151), // Replace with your desired border color
          // Adjust the border width as needed
        ),
        borderRadius: BorderRadius.circular(32), // Optional: to give rounded corners
      ),
      child: const Row(
        children: [],
      ),
    );
  }

  Widget _buildTitlesSection() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is TitlesUpdated) {
          return Column(
            children: state.titles
                .map((title) => Text(
                      title,
                      style: TextStyle(color: Colors.white),
                    ))
                .toList(growable: true),
          );
        }
        return const Text('Loading titles...');
      },
    );
  }

  Widget _buildCrestsSection() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is CrestsUpdated) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: state.crests.map((crest) => _buildCrestImage(crest)).toList(),
          );
        }
        return const Text('Loading crests...');
      },
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProjectsUpdated) {
          return Column(
            children: state.projects
                .map((project) => Text(
                      project,
                      style: TextStyle(color: Colors.white),
                    ))
                .toList(),
          );
        }
        return const Text('Loading projects...');
      },
    );
  }
}
