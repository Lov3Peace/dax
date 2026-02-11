import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../../../../../util/gradient_label.dart';
import '../../../../../../util/tactile_button.dart';

class CashWalletSection2 extends StatefulWidget {
  const CashWalletSection2({super.key});

  @override
  State<CashWalletSection2> createState() => CashWalletSection2State();
}

class CashWalletSection2State extends State<CashWalletSection2> {
  List<Map<String, String>> cards = [];
  int frontCardIndex = 0;

  List<Map<String, dynamic>> transactions = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─────────────────────────
        // CARDS HEADER
        // ─────────────────────────
        Row(
          spacing: 7.w(context),
          children: [
            Text(
              'Cards',
              style: TextStyle(
                fontSize: 7.sp(context),
                fontWeight: FontWeight.w800,
              ),
            ),
            TactileButton(
              onTap: () {},
              child: GradientContainer(
                gradient1: const Color.fromARGB(255, 85, 221, 89),
                gradient2: tran,
                height: 2.h(context),
                width: 4.w(context),
                neonGlow: tran,
                text: '+',
                textSize: 3.sp(context),
                borderColor: Colors.transparent,
                borderRadius: 500,
              ),
            ),
          ],
        ),

        SizedBox(height: 1.5.h(context)),

        // ─────────────────────────
        // CARD STACK / EMPTY STATE
        // ─────────────────────────
        cards.isEmpty
            ? emptyCards(context)
            : SizedBox(
                height: 24.h(context),
                width: 30.w(context),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: List.generate(cards.length, (index) {
                    final int pos =
                        (index - frontCardIndex + cards.length) % cards.length;

                    return Positioned(
                      top: pos * 10,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => setState(() => frontCardIndex = index),
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 200),
                          scale: pos == 0 ? 1.0 : 0.96,
                          child: buildCard(context, cards[index]),
                        ),
                      ),
                    );
                  }),
                ),
              ),

        SizedBox(height: 2.h(context)),

        // ─────────────────────────
        // TRANSACTIONS HEADER
        // ─────────────────────────
        Text(
          'Transaction History',
          style: TextStyle(
            fontSize: 4.sp(context),
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: .5.h(context)),
        Text(
          'Last 7 days',
          style: TextStyle(
            fontSize: 2.5.sp(context),
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
          ),
        ),

        SizedBox(height: 1.5.h(context)),

        // ─────────────────────────
        // TRANSACTION LIST
        // ─────────────────────────
        transactionList(context),
      ],
    );
  }

  // ===========================================================
  // EMPTY CARD STATE
  // ===========================================================
  Widget emptyCards(BuildContext context) {
    return Container(
      height: 24.h(context),
      width: 30.w(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Center(
        child: Text(
          "No cards added",
          style: TextStyle(
            fontSize: 3.sp(context),
            color: Colors.white60,
          ),
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, Map<String, String> card) {
    return Container(
      height: 24.h(context),
      width: 30.w(context),
      padding: EdgeInsets.all(3.w(context)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [blue, Color.fromARGB(255, 85, 221, 89)],
        ),
        boxShadow: const [
          BoxShadow(
            color: blue,
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(card["name"] ?? "", style: TextStyle(fontSize: 4.sp(context))),
          SizedBox(height: 1.h(context)),
          Text(card["number"] ?? "", style: TextStyle(fontSize: 4.sp(context))),
          const Spacer(),
          Text("Valid Thru: ${card["valid"] ?? ""}",
              style: TextStyle(fontSize: 3.sp(context))),
          Text("PIN: ${card["pin"] ?? ""}",
              style: TextStyle(fontSize: 3.sp(context))),
        ],
      ),
    );
  }

  Widget transactionList(BuildContext context) {
    if (transactions.isEmpty) {
      return Container(
        height: 32.5.h(context),
        width: 30.w(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white24),
        ),
        child: Center(
          child: Text(
            "No transactions in the last 7 days",
            style: TextStyle(
              fontSize: 3.sp(context),
              color: Colors.white60,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemCount: transactions.length,
      separatorBuilder: (_, __) => SizedBox(height: 1.2.h(context)),
      itemBuilder: (_, i) {
        final tx = transactions[i];
        return Container(
          padding: EdgeInsets.all(2.w(context)),
          decoration: BoxDecoration(
            color: const Color(0xFF24283B),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tx["name"],
                  style: TextStyle(
                      fontSize: 3.5.sp(context), color: Colors.white)),
              Text("\$${tx["amount"]}",
                  style: TextStyle(
                      fontSize: 3.5.sp(context), color: Colors.white70)),
            ],
          ),
        );
      },
    );
  }
}
