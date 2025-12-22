import 'package:flutter/material.dart';

class PixelIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;

  const PixelIcon(
    this.icon, {
    Key? key,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: (color ?? Theme.of(context).iconTheme.color)!,
          width: 2,
        ),
      ),
      child: Icon(
        icon,
        size: (size ?? 24) - 4,
        color: color ?? Theme.of(context).iconTheme.color,
      ),
    );
  }
}

class PixelAvatar extends StatelessWidget {
  final String emoji;
  final double size;
  final bool isOnline;
  final bool showBorder;

  const PixelAvatar({
    Key? key,
    required this.emoji,
    this.size = 50,
    this.isOnline = false,
    this.showBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              border: showBorder
                  ? Border.all(
                      color: Theme.of(context).dividerTheme.color!,
                      width: 2,
                    )
                  : null,
            ),
            child: Center(
              child: Text(
                emoji,
                style: TextStyle(fontSize: size * 0.6),
              ),
            ),
          ),
          if (isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: size * 0.25,
                height: size * 0.25,
                decoration: BoxDecoration(
                  color: const Color(0xFF25D366),
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}