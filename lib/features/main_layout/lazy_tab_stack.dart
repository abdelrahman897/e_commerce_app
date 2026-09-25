import 'package:flutter/material.dart';

class LazyTabStack extends StatefulWidget {
  final int index;
  final List<WidgetBuilder> tabsBody;
  const LazyTabStack({super.key, required this.index, required this.tabsBody});

  @override
  State<LazyTabStack> createState() => _LazyTabStackState();
}

class _LazyTabStackState extends State<LazyTabStack> {
  late final _visited = List.filled(widget.tabsBody.length, false);
  @override
  Widget build(BuildContext context) {
    _visited[widget.index] = true;
    return IndexedStack(index: widget.index , children: [
      for(var i =0; i < widget.tabsBody.length ; i++)
      _visited[i] ? widget.tabsBody[i](context) : const SizedBox.shrink(),
    ],);
  }
}
