import 'package:flutter/material.dart';

class MoveList extends StatelessWidget {
  const MoveList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              'Golpes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.water, color: Colors.blue),
            title: Text('Hydro Pump'),
          ),
          ListTile(
            leading: Icon(Icons.waves, color: Colors.blue),
            title: Text('Surf'),
          ),
          ListTile(
            leading: Icon(Icons.flash_on, color: Colors.yellow),
            title: Text('Thunderbolt'),
          ),
          ListTile(
            leading: Icon(Icons.flight, color: Colors.grey),
            title: Text('Hurricane'),
          ),
        ],
      ),
    );
  }
}