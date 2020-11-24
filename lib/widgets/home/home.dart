import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(50, (index) {
          return Container(
            height: 150,
            color: Colors.primaries[index % Colors.primaries.length],
          );
        }).toList(),
      ),
    );
  }
}
