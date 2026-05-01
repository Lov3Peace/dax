import 'dart:async';
import 'dart:ui';
import 'dart:convert';
import 'dart:ui' as html;
import 'package:http/browser_client.dart' as httpClient;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/main.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:go_router/go_router.dart';
import '../providers/userAuthProvider.dart';
import '../providers/userProvider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// @override
// void dispose() {
//   _timer.cancel();
// }
