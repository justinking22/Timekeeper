import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timekeeper/app/home/tab_item.dart';

class CupertinoHomeScaffold extends StatefulWidget {
  const CupertinoHomeScaffold(
      {required this.currentTab,
      required this.onSelectTab,
      required this.widgetBuilders,
      required this.navigatorKeys});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  State<CupertinoHomeScaffold> createState() => _CupertinoHomeScaffoldState();
}

class _CupertinoHomeScaffoldState extends State<CupertinoHomeScaffold> {
  late CupertinoTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CupertinoTabController();
  }

  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _controller,
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.jobs),
          _buildItem(TabItem.entries),
          _buildItem(TabItem.account),
        ],
        onTap: (index) {
          widget.onSelectTab(TabItem.values[index]);
          setState(() {});
        },
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
            navigatorKey: widget.navigatorKeys[item],
            builder: (context) => widget.widgetBuilders[item]!(context));
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final isSelected = _controller.index == TabItem.values.indexOf(tabItem);

    final color = isSelected ? Colors.indigo : Colors.grey;

    return BottomNavigationBarItem(
      icon: Icon(
        itemData?.icon,
        color: color,
      ),
      label: itemData?.title,
    );
  }
}
