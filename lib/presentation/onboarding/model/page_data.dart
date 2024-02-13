import 'package:flutter/material.dart';

class PageData {
  final String? title;
  final Widget? icon;
  final Color bgColor;
  final Color textColor;

  const PageData({
    this.title,
    this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}