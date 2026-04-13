import 'package:flutter/material.dart';

class MoveList extends StatelessWidget {
  final List<String> moves;

  const MoveList({super.key, required this.moves});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              'Golpes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ...moves.map(
            (move) => ListTile(
              leading: const Icon(Icons.flash_on),
              title: Text(move),
            ),
          ),
        ],
      ),
    );
  }
}