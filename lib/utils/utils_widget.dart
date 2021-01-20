import 'package:fitwith/utils/utils_common.dart';
import 'package:flutter/material.dart';

class WidgetUtils {
  /// Build Scaffold
  static Widget buildScaffold(Widget child, {Color backgroundColor = Colors.white, AppBar appBar, Widget drawer, Widget endDrawer}) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      drawer: drawer,
      endDrawer: endDrawer,
      body: SafeArea(
        child: child,
      ),
    );
  }

  /// Build App Bar
  static AppBar buildAppBar(
      {Color backgroundColor: Colors.white, String titleAssetPath = 'assets/logo_text_primary.png', Widget leading, Widget trailing}) {
    return AppBar(
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: CommonUtils.getPrimaryColor(),
      ),
      leading: leading,
      backgroundColor: backgroundColor,
      title: Image.asset(titleAssetPath, height: 24.0),
      centerTitle: true,
      actions: [
        if (trailing != null) trailing,
      ],
    );
  }

  /// Build notification icon
  static Widget buildNotificationIcon({bool isNew = false, double size = 20.0}) {
    // badge widget.
    final badge = Container(
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(32.0),
      ),
    );
    return Stack(
      children: [
        Icon(Icons.notifications, size: size, color: CommonUtils.getPrimaryColor()),
        if (isNew) Positioned(top: 0.0, left: 12.0, child: badge),
      ],
    );
  }

  /// Build default style button
  static Widget buildDefaultButton(String text, Function onPressed) {
    return RaisedButton(
      onPressed: onPressed,
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      color: CommonUtils.getPrimaryColor(),
    );
  }

  /// Build custom style button
  static Widget buildCustomButton(Widget child, Function onPressed, Color color, Color textColor,
      {double width,
      double elevation = 0.0,
      EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16.0),
      BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8.0))}) {
    Widget button = RaisedButton(
      elevation: elevation,
      padding: padding,
      onPressed: onPressed,
      child: child,
      color: color,
      textColor: textColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
    );

    if (width != null) {
      button = SizedBox(
        width: width,
        child: button,
      );
    }

    return button;
  }
}
