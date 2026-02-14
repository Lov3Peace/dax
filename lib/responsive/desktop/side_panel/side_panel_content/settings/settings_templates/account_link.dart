import 'dart:ui';
import 'package:flutter/material.dart';

class ConnectedAccountTile extends StatelessWidget {
  final String platform;
  final IconData icon;
  final bool connected;
  final VoidCallback onTap;

  const ConnectedAccountTile({
    super.key,
    required this.platform,
    required this.icon,
    required this.connected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final border = connected
        ? Colors.white.withOpacity(0.22)
        : Colors.white.withOpacity(0.12);

    final bg = connected
        ? Colors.white.withOpacity(0.08)
        : Colors.white.withOpacity(0.05);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: ClipRRect(
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
                      platform,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      connected ? "Connected" : "Not connected",
                      style: TextStyle(
                        color: connected ? Colors.white70 : Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withOpacity(0.14)),
                    color: Colors.black.withOpacity(0.10),
                  ),
                  child: Text(
                    connected ? "Disconnect" : "Connect",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
