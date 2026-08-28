import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlitzBannerCard extends StatelessWidget {
  const BlitzBannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF8E2DE2),
            Color(0xFF4A00E0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8E2DE2).withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Lightning bolt badge
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bolt_rounded,
              color: Colors.amberAccent,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),

          // Copy
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Match Madness',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '60s',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                const Text(
                  'Rapid-fire vocabulary blitz • Win Droplets 💧',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Play button
          FilledButton.icon(
            onPressed: () {
              context.push('/match-madness');
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.amberAccent,
              foregroundColor: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.play_arrow_rounded, size: 20),
            label: const Text(
              'Blitz',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
