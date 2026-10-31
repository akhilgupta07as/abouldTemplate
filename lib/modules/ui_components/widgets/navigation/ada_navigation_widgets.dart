import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class AdaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdaAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
    );
  }
}

class AdaBackButton extends StatelessWidget {
  const AdaBackButton({super.key, this.onPressed, this.label});

  final VoidCallback? onPressed;
  final String? label;

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return TextButton.icon(
        onPressed: onPressed ?? () => Navigator.maybePop(context),
        icon: const Icon(Icons.arrow_back_rounded, size: 20),
        label: Text(label!),
      );
    }
    return IconButton(
      tooltip: 'Back',
      onPressed: onPressed ?? () => Navigator.maybePop(context),
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }
}

class AdaBreadcrumb extends StatelessWidget {
  const AdaBreadcrumb({
    super.key,
    required this.segments,
    this.onSegmentTap,
  });

  final List<String> segments;
  final ValueChanged<int>? onSegmentTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        for (var i = 0; i < segments.length; i++) ...[
          if (i > 0)
            Icon(Icons.chevron_right, size: 18, color: scheme.onSurfaceVariant),
          InkWell(
            onTap: onSegmentTap != null ? () => onSegmentTap!(i) : null,
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text(
                segments[i],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: i == segments.length - 1
                          ? scheme.onSurface
                          : scheme.primary,
                      fontWeight:
                          i == segments.length - 1 ? FontWeight.w700 : FontWeight.w500,
                    ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class AdaTabNavigation extends StatelessWidget {
  const AdaTabNavigation({
    super.key,
    required this.tabs,
    required this.controller,
  });

  final List<String> tabs;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: tabs.map((t) => Tab(text: t)).toList(),
    );
  }
}

class AdaBottomNavigation extends StatelessWidget {
  const AdaBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: [
        for (final item in items)
          NavigationDestination(
            icon: item.icon,
            selectedIcon: item.activeIcon ?? item.icon,
            label: item.label!,
          ),
      ],
    );
  }
}

class AdaNavigationDrawer extends StatelessWidget {
  const AdaNavigationDrawer({
    super.key,
    required this.header,
    required this.items,
    this.selectedIndex = 0,
    this.onItemSelected,
  });

  final Widget header;
  final List<AdaDrawerItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: header,
          ),
          for (var i = 0; i < items.length; i++)
            ListTile(
              leading: Icon(items[i].icon),
              title: Text(items[i].label),
              selected: i == selectedIndex,
              onTap: () {
                Navigator.pop(context);
                onItemSelected?.call(i);
              },
            ),
        ],
      ),
    );
  }
}

class AdaDrawerItem {
  const AdaDrawerItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Demo shell: drawer + bottom nav + body (for showcase).
class AdaNavigationDemoShell extends StatefulWidget {
  const AdaNavigationDemoShell({super.key, required this.body});

  final Widget body;

  @override
  State<AdaNavigationDemoShell> createState() => _AdaNavigationDemoShellState();
}

class _AdaNavigationDemoShellState extends State<AdaNavigationDemoShell> {
  int _navIndex = 0;
  int _drawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation demo'),
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
      ),
      drawer: AdaNavigationDrawer(
        header: const Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'ADA Menu',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        selectedIndex: _drawerIndex,
        onItemSelected: (i) => setState(() => _drawerIndex = i),
        items: const [
          AdaDrawerItem(icon: Icons.home_outlined, label: 'Home'),
          AdaDrawerItem(icon: Icons.settings_outlined, label: 'Settings'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: widget.body,
      ),
      bottomNavigationBar: AdaBottomNavigation(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
