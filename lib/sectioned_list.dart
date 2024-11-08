
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

class SectionedList extends StatefulWidget {
  final List<SectionedListParameter> sections;

  const SectionedList({
    super.key,
    required this.sections,
  });

  @override
  State<StatefulWidget> createState() => _SectionedListState();
}

class _SectionedListState extends State<SectionedList> {
  final defaultGlobalKey = GlobalKey();

  void _scrollToSection(List<GlobalKey?> gbs) {
    final gb = gbs.firstWhere((gb) => gb != null, orElse: () => null);
    final BuildContext? currentContext = gb?.currentContext;
    if (currentContext != null) {
      Scrollable.ensureVisible(
        currentContext,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final List<GlobalKey?> gbs =
          widget.sections.map((s) => s.sectionFocusKey).toList();
      _scrollToSection(gbs);
    });

    return CustomScrollView(
      slivers: widget.sections.map((section) {
        return SliverList(
          key: section.sectionFocusKey,
          delegate: SliverChildBuilderDelegate(
            (context, index) => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                    color: const Color.fromARGB(255, 250, 237, 150),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: const Color.fromARGB(255, 220, 171, 237),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(section.sectionTitle ?? ""),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: section.section ?? Container(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            childCount: 1,
          ),
        );
      }).toList(),
    );
  }
}
