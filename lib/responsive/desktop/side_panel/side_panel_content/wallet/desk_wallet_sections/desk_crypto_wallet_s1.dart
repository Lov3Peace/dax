import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/tactile_button.dart';

import '../crypto_cash_wallet.dart';

class CryptoWalletSection1 extends StatefulWidget {
  final bool isCrypto;
  final VoidCallback onToggle;

  final double btcAmount;
  final double ethAmount;
  final double solAmount;
  final double xrpAmount;

  final double btcPrice;
  final double ethPrice;
  final double solPrice;
  final double xrpPrice;

  final String selectedAsset;
  final Function(String) onAssetSelected;

  const CryptoWalletSection1({
    super.key,
    required this.isCrypto,
    required this.onToggle,
    required this.selectedAsset,
    required this.onAssetSelected,
    required this.btcAmount,
    required this.ethAmount,
    required this.solAmount,
    required this.xrpAmount,
    required this.btcPrice,
    required this.ethPrice,
    required this.solPrice,
    required this.xrpPrice,
  });

  @override
  State<CryptoWalletSection1> createState() => CryptoWalletSection1State();
}

class CryptoWalletSection1State extends State<CryptoWalletSection1> {
  double totalPortfolioValue() {
    return (widget.btcAmount * widget.btcPrice) +
        (widget.ethAmount * widget.ethPrice) +
        (widget.solAmount * widget.solPrice) +
        (widget.xrpAmount * widget.xrpPrice);
  }

  double assetPercent(double amount, double price) {
    final total = totalPortfolioValue();
    if (total == 0) return 0;
    return (amount * price) / total * 100;
  }

  @override
  Widget build(BuildContext context) {
    final assets = [
      {
        "ticker": "BTC",
        "name": "Bitcoin",
        "icon": "₿",
        "amount": widget.btcAmount,
        "price": widget.btcPrice,
      },
      {
        "ticker": "ETH",
        "name": "Ethereum",
        "icon": "Ξ",
        "amount": widget.ethAmount,
        "price": widget.ethPrice,
      },
      {
        "ticker": "SOL",
        "name": "Solana",
        "icon": "◎",
        "amount": widget.solAmount,
        "price": widget.solPrice,
      },
      {
        "ticker": "XRP",
        "name": "XRP",
        "icon": "✕",
        "amount": widget.xrpAmount,
        "price": widget.xrpPrice,
      },
    ];

    final double availableValue = widget.btcAmount * widget.btcPrice;
    final double itemExtent = 9.h(context);
    return Padding(
      padding: EdgeInsets.only(left: 1.w(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2.h(context),
        children: [
          // ---------------------------------------------------------
          // TITLE + SWITCH
          // ---------------------------------------------------------
          Row(
            spacing: 7.w(context),
            children: [
              CashCryptoSwitch(
                isCrypto: widget.isCrypto,
                onToggle: widget.onToggle,
              ),
              Text(
                "Crypto Wallet",
                style: TextStyle(
                  fontSize: 7.sp(context),
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // ---------------------------------------------------------
          // AVAILABLE BALANCE
          // ---------------------------------------------------------
          Text(
            "Available Balance",
            style: TextStyle(
              fontSize: 3.sp(context),
              color: Colors.white70,
            ),
          ),
          Text(
            "\$${availableValue.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 6.5.sp(context),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 1.h(context)),

          // ---------------------------------------------------------
          // ACTION BUTTONS
          // ---------------------------------------------------------
          Row(
            spacing: 3.w(context),
            children: [
              actionButton("Fund", Icons.money),
              actionButton("Receive", Icons.download_rounded),
              actionButton("Convert", Icons.swap_horiz_rounded),
              actionButton("Withdraw", Icons.upload_rounded),
            ],
          ),

          SizedBox(height: 1.h(context)),

          // ---------------------------------------------------------
          // ASSET LIST
          // ---------------------------------------------------------
          Text(
            "Your Assets",
            style: TextStyle(
              fontSize: 3.3.sp(context),
              color: Colors.white70,
            ),
          ),

          Container(
            height: 30.h(context),
            width: 30.w(context),
            child: ListWheelScrollView.useDelegate(
              itemExtent: itemExtent,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                final ticker = assets[index]["ticker"] as String;
                widget.onAssetSelected(ticker);
              },
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: assets.length,
                builder: (context, index) {
                  final asset = assets[index];
                  final bool active = asset["ticker"] == widget.selectedAsset;

                  return _wheelItem(
                    context,
                    asset,
                    active,
                    itemExtent,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // ACTION BUTTON BUILDER
  // ---------------------------------------------------------
  Widget actionButton(String label, IconData icon) {
    return Column(
      children: [
        TactileButton(
          onTap: () {},
          child: GradientContainer(
            gradient1: blue,
            gradient2: purp,
            height: 5.5.h(context),
            width: 5.5.h(context),
            neonGlow: purp,
            borderRadius: 18,
            borderColor: Colors.transparent,
            text: String.fromCharCode(icon.codePoint),
            textSize: 3.sp(context),
          ),
        ),
        SizedBox(height: .8.h(context)),
        Text(
          label,
          style: TextStyle(
            fontSize: 2.6.sp(context),
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _wheelItem(
    BuildContext context,
    Map<String, dynamic> asset,
    bool active,
    double itemExtent,
  ) {
    return SizedBox(
      height: itemExtent,
      child: Center(
        // keeps content vertically centered
        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: active ? 1.05 : 0.95,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: active ? 1.0 : 0.55,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w(context),
                vertical: 2.h(context), // must fit inside itemExtent
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF24283B),
                borderRadius: BorderRadius.circular(18),
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: blue.withOpacity(.35),
                          blurRadius: 12,
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ICON
                  Text(
                    asset["icon"] as String,
                    style: TextStyle(
                      fontSize: 4.sp(context),
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(width: 2.w(context)),

                  // LEFT: TICKER + NAME
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        asset["ticker"] as String,
                        style: TextStyle(
                          fontSize: 3.5.sp(context),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        asset["name"] as String,
                        style: TextStyle(
                          fontSize: 2.4.sp(context),
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 4.w(context)),

                  // RIGHT: AMOUNT + PERCENT
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        (asset["amount"] as double).toStringAsFixed(6),
                        style: TextStyle(
                          fontSize: 3.2.sp(context),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${assetPercent(
                          asset["amount"] as double,
                          asset["price"] as double,
                        ).toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: 2.4.sp(context),
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
