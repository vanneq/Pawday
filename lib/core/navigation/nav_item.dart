import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final IconData iconSelected;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.iconSelected,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final inactive = Theme.of(context).colorScheme.secondary;
    final color = selected ? primary : inactive;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(selected ? iconSelected : icon, size: 22, color: color),
            const SizedBox(height: 4),
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
