import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/navigation/nav_item.dart';

class NavBar extends ConsumerWidget {
  final Widget child;
  const NavBar({super.key, required this.child});

  static const _tabs = ['/main', '/diary', '/profile'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();

    final currentIndex = _tabs.indexWhere((tab) {
      if (tab == '/main') return location == '/main';
      return location.startsWith(tab);
    });

    return Scaffold(
      bottomNavigationBar: _FloatingNavBar(
        currentIndex: currentIndex,
        onTap: (i) => context.go(_tabs[i]),
      ),
      body: child,
    );
  }
}

class _FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const _FloatingNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Container(
        height: 68,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary.withAlpha(80),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: NavItem(
                icon: Icons.home_outlined,
                iconSelected: Icons.home_rounded,
                text: 'Главная',
                selected: currentIndex == 0,
                onTap: () => onTap(0),
              ),
            ),
            Expanded(
              child: NavItem(
                icon: Icons.menu_book_outlined,
                iconSelected: Icons.menu_book_rounded,
                text: 'Дневник',
                selected: currentIndex == 1,
                onTap: () => onTap(1),
              ),
            ),
            Expanded(
              child: NavItem(
                icon: Icons.person_outline,
                iconSelected: Icons.person_rounded,
                text: 'Профиль',
                selected: currentIndex == 2,
                onTap: () => onTap(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
