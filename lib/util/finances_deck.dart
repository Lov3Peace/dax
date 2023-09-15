import 'package:flutter/material.dart';
import 'decks.dart';

class FinancesDeck extends StatelessWidget {
  FinancesDeck({super.key, this.onTap, this.color});

  VoidCallback? onTap;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Deck(
        deckHeight: MediaQuery.of(context).size.height * 0.1,
        deckWidth: MediaQuery.of(context).size.width * 0.45,
        deckName: 'Finances',
        gradient1: const Color.fromARGB(255, 157, 255, 45),
        gradient2: const Color.fromARGB(255, 59, 193, 255),
        neonGlow: const Color.fromARGB(169, 136, 255, 0),
        onTap: onTap,
      ),
    );
  }
}
