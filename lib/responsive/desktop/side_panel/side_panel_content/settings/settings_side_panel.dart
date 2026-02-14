import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

import '../../../desk_decks.dart';

class SettingsNavRail extends StatefulWidget {
  final String selected;
  final ValueChanged<String> onSelect;

  const SettingsNavRail({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  State<SettingsNavRail> createState() => _SettingsNavRailState();
}

class _SettingsNavRailState extends State<SettingsNavRail> {
  final items = const [
    NavItem("account", Icons.person_outline, "Account"),
    NavItem("wallet", Icons.account_balance_wallet_outlined, "Wallet"),
    NavItem("security", Icons.lock_outline, "Security"),
    NavItem("appearance", Icons.palette_outlined, "Appearance"),
    NavItem("notifications", Icons.notifications_none, "Notifications"),
    NavItem("advanced", Icons.settings_outlined, "Advanced"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h(context),
      width: 5.w(context),
      padding: EdgeInsets.symmetric(vertical: 2.h(context)),
      decoration: BoxDecoration(
        color: const Color.fromARGB(70, 32, 32, 40),
        borderRadius: const BorderRadius.all(
          Radius.circular(80),
        ),
        border: Border.all(color: deckBorderColor),
      ),
      child: Column(
        spacing: 1.6.h(context),
        children: items.map((item) {
          final bool active = widget.selected == item.key;

          return Tooltip(
            message: item.label,
            waitDuration: const Duration(milliseconds: 120),
            verticalOffset: 0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.85),
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 2.6.sp(context),
            ),
            child: GestureDetector(
              onTap: () => widget.onSelect(item.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                curve: Curves.easeOut,
                height: 5.h(context),
                width: 5.h(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: active ? blue.withOpacity(.18) : Colors.transparent,
                  boxShadow: active
                      ? [
                          BoxShadow(
                            color: blue.withOpacity(.45),
                            blurRadius: 12,
                          )
                        ]
                      : [],
                ),
                child: Icon(
                  item.icon,
                  size: 3.h(context),
                  color: active ? Colors.white : Colors.white70,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class NavItem {
  final String key;
  final IconData icon;
  final String label;

  const NavItem(this.key, this.icon, this.label);
}
