import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/providers/locationServicesProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../desk_decks.dart';

class WeatherDate extends StatelessWidget {
  final double width;
  final double height;
  final BoxConstraints constraints;
  final VoidCallback? onTap;

  const WeatherDate({
    this.width = 0,
    this.height = 0,
    required this.constraints,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Watch LocationServicesProvider in build
    final locationServicesProvider = context.watch<LocationServicesProvider>();
    weatherTemp = locationServicesProvider.weatherTemp;
    weatherIcon = locationServicesProvider.weatherIcon;
    weatherDescription = locationServicesProvider.weatherDescription;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // spacing: max(5, 0.25.w(context)),
      children: [
        //
        // OpenWeatherMap API Icon
        Image.network(
          fit: BoxFit.cover,
          width: max(10, 3.w(context)),
          "https://openweathermap.org/img/wn/$weatherIcon@2x.png",
          // Show Cloud Off icon if api response is loading
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return const Icon(Icons.cloud_off_rounded);
          },
          errorBuilder: (context, child, error) {
            // Show Cloud Off icon on error or until Provider updates
            return const Icon(Icons.cloud_off_rounded);
          },
        ),
        //
        // Temperature
        Text.rich(TextSpan(children: [
          TextSpan(
              text: weatherTemp,
              style: GoogleFonts.montserrat(
                fontSize: 3.sp(context),
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
          const TextSpan(text: "  "),
          //
          // Date
          TextSpan(
              text: DateFormat.yMMMEd().format(DateTime.now()),
              style: GoogleFonts.montserrat(
                fontSize: 3.sp(context),
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ))
        ])),
      ],
    );
  }
}

String weatherTemp = "";
String weatherDescription = "";
String weatherIcon = "01d";
