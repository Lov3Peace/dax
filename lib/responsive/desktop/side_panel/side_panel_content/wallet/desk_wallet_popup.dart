import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/side_panel/side_panel_content/desk_dock_button_templates/sp_card_template.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../desk_decks.dart';
import 'desk_wallet_sections/desk_crypto_wallet_s1.dart';
import 'desk_wallet_sections/desk_crypto_wallet_s2.dart';
import 'desk_wallet_sections/desk_wallet_c1.dart';
import 'desk_wallet_sections/desk_wallet_c2.dart';

Control slideWallet = Control.stop;

class WalletPopUp extends StatefulWidget {
  const WalletPopUp({super.key});

  @override
  State<WalletPopUp> createState() => WalletPopUpState();
}

class WalletPopUpState extends State<WalletPopUp> with AnimationMixin {
  double cashBalance = 0.0; // starts at zero

  double btcAmount = 0.0;
  double ethAmount = 0.0;
  double solAmount = 0.0;
  double xrpAmount = 0.0;

  double btcPrice = 0.0;
  double ethPrice = 0.0;
  double solPrice = 0.0;
  double xrpPrice = 0.0;

  List<double> priceHistory = [];

  String selectedAsset = "BTC";
  ValueNotifier<List<double>> chartData = ValueNotifier([]);
  bool isCrypto = false; // 🔥 MASTER STATE controlling everything

  void toggle() {
    setState(() {
      isCrypto = !isCrypto;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SPCardTemplate(
      height: 100.h(context),
      width: 71.w(context),
      borderColor: deckBorderColor,
      child: Padding(
        padding: EdgeInsets.only(top: 2.h(context)),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: isCrypto ? buildCryptoScreen() : buildCashScreen(),
        ),
      ),
    );
  }

// 🔥 CASH SCREEN = Section 1 + Divider + Section 2
  Widget buildCashScreen() {
    return Row(
      key: const ValueKey("cash"),
      spacing: .5.w(context),
      children: [
        CashWalletSection1(
          isCrypto: isCrypto,
          onToggle: toggle,
          cashBalance: cashBalance, // 🔥 REQUIRED
        ),
        VerticalDivider(
          thickness: 1,
          color: tran,
          indent: 100,
          endIndent: 100,
        ),
        CashWalletSection2(),
      ],
    );
  }

// 🔥 CRYPTO SCREEN = CryptoSection1 + Divider + CryptoSection2
  Widget buildCryptoScreen() {
    return Row(
      key: const ValueKey("crypto"),
      spacing: .5.w(context),
      children: [
        CryptoWalletSection1(
          isCrypto: isCrypto,
          onToggle: toggle,
          selectedAsset: selectedAsset,
          onAssetSelected: (asset) {
            setState(() {
              selectedAsset = asset;
            });
          },

          // balances & prices
          btcAmount: btcAmount,
          ethAmount: ethAmount,
          solAmount: solAmount,
          xrpAmount: xrpAmount,
          btcPrice: btcPrice,
          ethPrice: ethPrice,
          solPrice: solPrice,
          xrpPrice: xrpPrice,
        ),
        VerticalDivider(
          thickness: 1,
          color: tran,
          indent: 100,
          endIndent: 100,
        ),
        CryptoWalletSection2(
          selectedAsset:
              selectedAsset, // <- update this when you tap an asset row
        ),
      ],
    );
  }
}
