import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../../../../../util/gradient_label.dart';
import '../../../../../../util/tactile_button.dart';
import '../crypto_cash_wallet.dart';

class CashWalletSection1 extends StatefulWidget {
  final bool isCrypto;
  final VoidCallback onToggle;

  final double cashBalance;

  const CashWalletSection1({
    super.key,
    required this.isCrypto,
    required this.onToggle,
    required this.cashBalance,
  });

  @override
  State<CashWalletSection1> createState() => CashWalletSection1State();
}

class CashWalletSection1State extends State<CashWalletSection1> {
  String tab = "people";

  String? activeAction; // "Fund" | "Send" | "Withdraw" | "Allocate"

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.w(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─────────────────────────────────────────
          // HEADER
          // ─────────────────────────────────────────
          Row(
            spacing: 7.w(context),
            children: [
              CashCryptoSwitch(
                isCrypto: widget.isCrypto,
                onToggle: widget.onToggle,
              ),
              Text(
                'Cash Wallet',
                style: TextStyle(
                  fontSize: 7.sp(context),
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h(context)),

          // ─────────────────────────────────────────
          // BALANCE BLOCK (ANCHOR)
          // ─────────────────────────────────────────
          Text(
            "Available Balance",
            style: TextStyle(
              fontSize: 3.sp(context),
              color: Colors.white60,
              letterSpacing: .5,
            ),
          ),
          SizedBox(height: .8.h(context)),

          Text(
            "\$${widget.cashBalance.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 7.sp(context),
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 4.h(context)),

          // ─────────────────────────────────────────
          // ACTION BUTTONS (CALM, TACTILE)
          // ─────────────────────────────────────────
          Row(
            spacing: 3.5.w(context),
            children: [
              buildAction(context, "Fund", Icons.add),
              buildAction(context, "Send", Icons.arrow_upward_rounded),
              buildAction(context, "Withdraw", Icons.arrow_downward_rounded),
              buildAction(context, "Allocate", Icons.account_tree_outlined),
            ],
          ),

          SizedBox(height: 5.h(context)),

          // ─────────────────────────────────────────
          // PEOPLE / PROJECTS TOGGLE
          // ─────────────────────────────────────────
          Row(
            spacing: 2.5.w(context),
            children: [
              buildTab(context, "People", tab == "people"),
              buildTab(context, "Projects", tab == "projects"),
            ],
          ),

          SizedBox(height: 2.h(context)),

          // ─────────────────────────────────────────
          // CONTENT AREA
          // ─────────────────────────────────────────
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: tab == "people"
                ? peopleContainer(context)
                : projectsContainer(context),
          ),
        ],
      ),
    );
  }

  // =================================================
  // ACTION BUTTON
  // =================================================

  Widget buildAction(
    BuildContext context,
    String label,
    IconData icon,
  ) {
    final bool isWithdraw = label == "Withdraw";
    final bool disabled = isWithdraw && widget.cashBalance == 0;
    final bool active = activeAction == label && !disabled;

    return Column(
      children: [
        TactileButton(
          onTap: disabled
              ? null
              : () {
                  setState(() {
                    activeAction = active ? null : label;
                  });
                },
          child: GradientContainer(
            gradient1: active
                ? const Color.fromARGB(255, 85, 221, 89)
                : disabled
                    ? tran
                    : tran,
            gradient2: active
                ? tran
                : disabled
                    ? tran
                    : Colors.grey.shade900,
            height: 5.5.h(context),
            width: 5.5.h(context),
            borderRadius: 18,
            borderColor: active ? Colors.transparent : Colors.white12,
            neonGlow: active ? tran : Colors.transparent,

            // ICON
            text: String.fromCharCode(icon.codePoint),
            textSize: 3.5.sp(context),
          ),
        ),
        SizedBox(height: .7.h(context)),
        Text(
          label,
          style: TextStyle(
            fontSize: 2.5.sp(context),
            color: disabled
                ? Colors.white38
                : active
                    ? Colors.white
                    : Colors.white70,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // =================================================
  // TAB BUTTON
  // =================================================
  Widget buildTab(BuildContext context, String label, bool active) {
    return TactileButton(
      onTap: () => setState(() => tab = label.toLowerCase()),
      child: GradientContainer(
        gradient1: active ? const Color.fromARGB(255, 85, 221, 89) : tran,
        gradient2: active ? tran : Colors.grey.shade900,
        height: 1.6.h(context),
        width: 13.w(context),
        neonGlow: active ? Colors.transparent : Colors.transparent,
        text: label,
        textSize: 3.8.sp(context),
        borderRadius: 16,
        borderColor: active ? Colors.transparent : Colors.white12,
      ),
    );
  }

  // =================================================
  // PEOPLE CONTAINER
  // =================================================
  Widget peopleContainer(BuildContext context) {
    return Container(
      key: const ValueKey("people"),
      height: 32.h(context),
      width: 30.w(context),
      decoration: BoxDecoration(
        color: tran,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
      ),
      child: Center(
        child: Text(
          "Your Friends List",
          style: TextStyle(
            fontSize: 3.sp(context),
            color: Colors.white60,
          ),
        ),
      ),
    );
  }

  // =================================================
  // PROJECTS CONTAINER
  // =================================================
  Widget projectsContainer(BuildContext context) {
    return Container(
      key: const ValueKey("projects"),
      height: 32.h(context),
      width: 30.w(context),
      decoration: BoxDecoration(
        color: tran,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
      ),
      child: Center(
        child: Text(
          "Your Projects",
          style: TextStyle(
            fontSize: 3.sp(context),
            color: Colors.white60,
          ),
        ),
      ),
    );
  }
}
