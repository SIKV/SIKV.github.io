import 'package:cv/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<BottomNavigationBarItem> items;
  final Widget childRight;
  final ValueChanged<int> onTap;
  final int currentIndex;
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;

  CustomBottomNavigationBar({
    @required this.items,
    this.childRight,
    this.onTap,
    this.currentIndex = 0,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  }) : assert(items != null);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    List<_Tile> tiles = [];

    for (int i = 0; i < widget.items.length; i++) {
      tiles.add(_Tile(
        item: widget.items[i],
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap(i);
          }
        },
        selected: i == widget.currentIndex,
        selectedItemColor: widget.selectedItemColor,
        unselectedItemColor: widget.unselectedItemColor,
      ));
    }

    Widget childRight = SizedBox();

    if (!isPortraitOrientation(context) && widget.childRight != null) {
      childRight = Positioned(
        right: 16,
        child: widget.childRight,
      );
    }

    return Container(
      width: double.infinity,
      color: widget.backgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: isPortraitOrientation(context) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: tiles,
            ),
          ),
          childRight,
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final BottomNavigationBarItem item;
  final VoidCallback onTap;
  final bool selected;
  final Color selectedItemColor;
  final Color unselectedItemColor;

  const _Tile({
    this.item,
    this.onTap,
    this.selected = false,
    this.selectedItemColor,
    this.unselectedItemColor,
  }) : assert(item != null),
       assert(selected != null);

  @override
  Widget build(BuildContext context) {
    Color color = selected ? selectedItemColor : unselectedItemColor;

    return Material(
      type: MaterialType.transparency,
      child: InkResponse(
        onTap: onTap,
        highlightShape: BoxShape.circle,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, top: 8, right: 24, bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconTheme(
                data: IconThemeData(
                  color: color,
                ),
                child: item.icon,
              ),

              SizedBox(height: 4),

              DefaultTextStyle.merge(
                style: TextStyle(
                  color: color,
                  fontSize: 9,
                  letterSpacing: 1,
                ),
                child: Text(item.label.toUpperCase()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}