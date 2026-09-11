import 'package:flutter/material.dart';

class ScoreCounter extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ScoreCounter({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(label),
        ),

        IconButton(
          onPressed: onDecrement,
          icon: const Icon(Icons.remove),
        ),

        Text(
          "$value",
          style: const TextStyle(fontSize: 18),
        ),

        IconButton(
          onPressed: onIncrement,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}