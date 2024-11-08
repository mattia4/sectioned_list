import 'package:flutter/material.dart';

class SectionedListParameter {
  String? sectionTitle;
  Widget? section;
  GlobalKey? sectionFocusKey;

  SectionedListParameter({
    required this.sectionTitle,
    required this.section,
    this.sectionFocusKey,
  });
}
