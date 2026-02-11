import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../../desk_decks.dart';
import 'settings_side_panel_info/account_settings.dart';
import 'settings_side_panel_info/wallet_settings.dart';

class SettingsContentPanel extends StatelessWidget {
  final String tab;

  const SettingsContentPanel({
    super.key,
    required this.tab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h(context),
      width: 55.w(context),
      padding: EdgeInsets.all(1.w(context)),
      decoration: BoxDecoration(
        color: const Color.fromARGB(70, 32, 32, 40),
        borderRadius: const BorderRadius.all(
          Radius.circular(40),
        ),
        border: Border.all(color: deckBorderColor),
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: buildContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    switch (tab) {
      case "account":
        return AccountSettings();
      case "wallet":
        return WalletSettings();
      // case "security":
      //   return securitySettings(context);
      // case "appearance":
      //   return appearanceSettings(context);
      // case "notifications":
      //   return notificationSettings(context);
      // case "advanced":
      //   return advancedSettings(context);
      default:
        return const SizedBox.shrink();
    }
  }
}
