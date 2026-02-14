import 'dart:ui';
import 'package:flutter/material.dart';

class Devices extends StatelessWidget {
  final String device;
  final IconData icon;
  final bool trusted;
  final VoidCallback onToggleTrusted;
  final VoidCallback onRemove;

  const Devices({
    super.key,
    required this.device,
    required this.icon,
    required this.trusted,
    required this.onToggleTrusted,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final border = trusted
        ? Colors.white.withOpacity(0.22)
        : Colors.white.withOpacity(0.12);

    final bg = trusted
        ? Colors.white.withOpacity(0.08)
        : Colors.white.withOpacity(0.05);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white70, size: 18),
              const SizedBox(width: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    device,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    trusted ? "Trusted" : "Untrusted",
                    style: TextStyle(
                      color: trusted ? Colors.white70 : Colors.white54,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              // Toggle Trusted
              InkWell(
                onTap: onToggleTrusted,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withOpacity(0.14)),
                    color: Colors.black.withOpacity(0.10),
                  ),
                  child: Text(
                    trusted ? "Untrust" : "Trust",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Remove
              InkWell(
                onTap: onRemove,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withOpacity(0.14)),
                    color: Colors.black.withOpacity(0.10),
                  ),
                  child: const Text(
                    "Remove",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
