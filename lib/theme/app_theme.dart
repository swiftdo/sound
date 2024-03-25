import 'package:flutter/material.dart';

class AppTheme {
  static final theme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      color: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 5.0,
      centerTitle: false,
    ),
    fontFamily: "MiniTex",
    fontFamilyFallback: ["MiniTex"],
    /**
     * 使用 iOS 风格页面转场
     */
    platform: TargetPlatform.iOS,
  );
}
