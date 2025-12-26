import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

/// زر مخصص مع أيقونة
class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final double size;
  final String? tooltip;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color,
    this.size = 24,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: color ?? Colors.white,
        size: size,
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }
    return button;
  }
}

/// بطاقة مخصصة للتطبيق
class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderRadius;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.margin,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin ?? const EdgeInsets.all(4),
        padding: padding ?? const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color ?? Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        child: child,
      ),
    );
  }
}

/// شريط التطبيق المخصص
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final List<Widget>? actions;
  final Widget? leading;
  final double toolbarHeight;
  final bool animate;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.backgroundColor,
    this.actions,
    this.leading,
    this.toolbarHeight = 75,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = Text(
      title,
      style: TextStyle(
        fontFamily: 'BigVesta-Arabic-Regular',
        height: 0.7,
        fontSize: MediaQuery.of(context).size.width / 17,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    if (animate) {
      titleWidget = FadeInRight(
        duration: const Duration(milliseconds: 500),
        child: titleWidget,
      );
    }

    return AppBar(
      toolbarHeight: toolbarHeight,
      backgroundColor: backgroundColor,
      scrolledUnderElevation: 5,
      leadingWidth: leading != null ? 56 : 0,
      leading: leading ?? const SizedBox(),
      title: titleWidget,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}

/// مؤشر التحميل المخصص
class CustomLoader extends StatelessWidget {
  final Color? color;
  final double size;

  const CustomLoader({
    super.key,
    this.color,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color ?? Colors.white,
          strokeWidth: 3,
        ),
      ),
    );
  }
}

/// زر عائم مخصص
class CustomFAB extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final String? tooltip;

  const CustomFAB({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: tooltip,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      highlightElevation: 0,
      onPressed: onPressed,
      child: CircleAvatar(
        backgroundColor: backgroundColor?.withOpacity(0.4) ?? Colors.white24,
        radius: 20,
        child: Icon(
          icon,
          size: 22,
          color: iconColor ?? Colors.white,
        ),
      ),
    );
  }
}

/// مربع حوار مخصص
class CustomDialog extends StatelessWidget {
  final String? title;
  final Widget content;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const CustomDialog({
    super.key,
    this.title,
    required this.content,
    this.actions,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: backgroundColor ?? Colors.grey[900],
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'BigVesta-Arabic-Regular',
              ),
              textAlign: TextAlign.center,
            )
          : null,
      content: content,
      actions: actions,
    );
  }

  /// عرض مربع الحوار
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    required Widget content,
    List<Widget>? actions,
    Color? backgroundColor,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => CustomDialog(
        title: title,
        content: content,
        actions: actions,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
