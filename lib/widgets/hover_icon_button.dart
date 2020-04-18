import 'package:flutter/material.dart';

class HoverIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  final Color color;
  final Color hoverColor;
  final contentColor;
  final Color contentHoverColor;

  const HoverIconButton({
    this.onPressed,
    this.icon,
    this.text,
    this.color,
    this.hoverColor,
    this.contentColor,
    this.contentHoverColor,
  });

  @override
  _HoverIconButtonState createState() => _HoverIconButtonState();
}

class _HoverIconButtonState extends State<HoverIconButton> {
  Color _bgColor;
  Color _contentColor;

  @override
  void initState() {
    super.initState();

    _bgColor = widget.color;
    _contentColor = widget.contentColor;
  }

  void _handleHoveredChanged(bool value) {
    setState(() {
      _bgColor = value ? widget.hoverColor : widget.color;
      _contentColor = value ? widget.contentHoverColor : widget.contentColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Icon(widget.icon,
        size: 22,
        color: _contentColor,
      ),
    ];

    if (widget.text != null) {
      children.add(SizedBox(width: 6));

      children.add(
        Text(widget.text,
          style: Theme.of(context).textTheme.overline.copyWith(
            fontSize: 12,
            color: _contentColor
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: widget.onPressed,
        onHover: _handleHoveredChanged,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Row(
            children: children
        ),
      ),
    );
  }
}