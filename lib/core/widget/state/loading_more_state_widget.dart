import 'package:flutter/material.dart';

class LoadingMoreStateWidget extends StatelessWidget {
  const LoadingMoreStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
