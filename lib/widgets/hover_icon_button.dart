import 'package:flutter/material.dart';

class HoverIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final Color color;
  final Color hoverColor;
  final Color textColor;
  final Color textHoverColor;
  final Color iconColor;
  final Color iconHoverColor;

  const HoverIconButton({
    this.onPressed,
    this.text,
    this.icon,
    this.color,
    this.hoverColor,
    this.textColor,
    this.textHoverColor,
    this.iconColor,
    this.iconHoverColor
  });

  @override
  _HoverIconButtonState createState() => _HoverIconButtonState();
}

class _HoverIconButtonState extends State<HoverIconButton> {
  Color _color;
  Color _textColor;
  Color _iconColor;

  @override
  void initState() {
    super.initState();

    _color = widget.color;
    _textColor = widget.textColor;
    _iconColor = widget.iconColor;
  }

  void _handleHoveredChanged(bool value) {
    setState(() {
      _color = value ? widget.hoverColor : widget.color;
      _textColor = value ? widget.textHoverColor : widget.textColor;
      _iconColor = value ? widget.iconHoverColor : widget.iconColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Icon(widget.icon,
        size: 22,
        color: _iconColor,
      ),
    ];

    if (widget.text != null) {
      children.add(SizedBox(width: 6));

      children.add(
        Text(widget.text,
          style: Theme.of(context).textTheme.button.copyWith(
            color: _textColor,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: _color,
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