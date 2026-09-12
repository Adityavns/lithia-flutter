import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xff1454a6), size: 22),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xff1454a6),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}

class ActionDivider extends StatelessWidget {
  const ActionDivider({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(
    height: 34,
    child: VerticalDivider(width: 1, color: Color(0xffdddddd)),
  );
}
