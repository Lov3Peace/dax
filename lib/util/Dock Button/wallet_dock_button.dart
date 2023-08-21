import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/util/Window%20Route/wallet_window_route.dart';
import 'package:ionicons/ionicons.dart';

class WalletWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const WalletWindowButton({super.key, required});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(WalletWindowRoute(builder: (context) {
            return const _WalletWindowPopupCard();
          }));
        },
        child: const Hero(
          tag: _heroWalletWindow,
          child: Material(
            color: tran,
            child: Icon(
              Ionicons.wallet,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroWalletWindow = 'Wallet-window-hero';

class _WalletWindowPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const _WalletWindowPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroWalletWindow,
          /*createRectTween: (begin, end) {
            return Tween(begin: begin, end: end);
          },*/
          child: Material(
            color: const Color(0xA9444444),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Wallet',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Write a note',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 6,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
