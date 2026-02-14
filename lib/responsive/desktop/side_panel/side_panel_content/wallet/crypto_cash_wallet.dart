import 'package:flutter/material.dart';

class CashCryptoSwitch extends StatelessWidget {
  final bool isCrypto;
  final VoidCallback onToggle;

  const CashCryptoSwitch({
    super.key,
    required this.isCrypto,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 80,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isCrypto ? Colors.blue : Colors.green,
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment:
                  isCrypto ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCrypto ? Icons.currency_bitcoin : Icons.attach_money,
                  size: 20,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
