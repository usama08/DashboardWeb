import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ToastPosition {
  top,
  left,
  right,
}

class CustomToast {
  static void show(
    BuildContext context, {
    required String message,
    ToastPosition position = ToastPosition.top,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.white,
    Widget? image,
    Color? shadhowColor,
    TextStyle textStyle = const TextStyle(color: Colors.black),
    double? imageWidth,
    double? imageHeight,
    double paddingHorizontal = 30.0,
    double paddingVertical = 10.0,
  }) {
    // Check platform
    if (kIsWeb) {
      // Use a more web-friendly method like a Snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message, style: textStyle),
        duration: duration,
        backgroundColor: backgroundColor,
      ));
      return;
    }

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => ToastMessage(
        message: message,
        position: position,
        backgroundColor: backgroundColor,
        textStyle: textStyle,
        duration: duration,
        image: image,
        shadowColor: shadhowColor,
        imageWidth: imageWidth,
        imageHeight: imageHeight,
        paddingHorizontal: paddingHorizontal,
        paddingVertical: paddingVertical,
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(duration, () => overlayEntry.remove());
  }
}

class ToastMessage extends StatefulWidget {
  final String message;
  final ToastPosition position;
  final Duration duration;
  final Color backgroundColor;
  final Widget? image;
  final TextStyle textStyle;
  final Color? shadowColor;
  final double? imageWidth;
  final double? imageHeight;
  final double paddingHorizontal;
  final double paddingVertical;

  const ToastMessage({
    super.key,
    required this.message,
    required this.position,
    required this.duration,
    required this.backgroundColor,
    this.image,
    this.shadowColor,
    required this.textStyle,
    this.imageWidth,
    this.imageHeight,
    this.paddingHorizontal = 30.0,
    this.paddingVertical = 10.0,
  });

  @override
  __ToastMessageState createState() => __ToastMessageState();
}

class __ToastMessageState extends State<ToastMessage>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _offsetAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: _getOffset(),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  Offset _getOffset() {
    switch (widget.position) {
      case ToastPosition.left:
        return const Offset(-1.0, 0.0);
      case ToastPosition.right:
        return const Offset(1.0, 0.0);
      case ToastPosition.top:
      default:
        return const Offset(0.0, -1.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.position == ToastPosition.top ? 10.0 : null,
      left: widget.position == ToastPosition.left ? 5.0 : null,
      right: widget.position == ToastPosition.right ? 20.0 : null,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(top: 30, right: 20, left: 40),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 40),
              padding: EdgeInsets.symmetric(
                horizontal: widget.paddingHorizontal,
                vertical: widget.paddingVertical,
              ),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: widget.shadowColor == null
                        ? Colors.black.withOpacity(0.2)
                        : widget.shadowColor!,
                    offset: const Offset(2, 4),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.image != null) ...[
                    SizedBox(
                      width: widget.imageWidth ?? 30,
                      height: widget.imageHeight ?? 30,
                      child: widget.image!,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      widget.message,
                      maxLines: 3,
                      style: widget.textStyle,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
