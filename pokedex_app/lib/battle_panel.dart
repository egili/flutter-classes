import 'package:flutter/material.dart';
import 'stat_bar.dart';

class BattlePanel extends StatefulWidget {
  const BattlePanel({super.key});

  @override
  State<BattlePanel> createState() => _BattlePanelState();
}

class _BattlePanelState extends State<BattlePanel> {
  int hp = 100;
  int xp = 0;
  int level = 42;

  Color get hpColor {
    if (hp > 60) return Colors.green;
    if (hp > 30) return Colors.yellow;
    return Colors.red;
  }

  String get statusMessage {
    if (hp == 0) return 'Gyarados desmaiou!';
    if (hp <= 30) return 'HP crítico!';
    return '';
  }

  void _atacar() {
    setState(() {
      hp = (hp - 20).clamp(0, 100);
      xp += 10;

      if (xp >= 100) {
        level++;
        xp = 0;
      }
    });
  }

  void _usarPocao() {
    setState(() {
      hp = (hp + 30).clamp(0, 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Nível $level',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            StatBar(label: 'HP', value: hp, maxValue: 100, color: hpColor),
            StatBar(label: 'XP', value: xp, maxValue: 100, color: Colors.blue),

            if (statusMessage.isNotEmpty) ...[
              SizedBox(height: 8),
              Text(
                statusMessage,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],

            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: hp > 0 ? _atacar : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Atacar'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: hp < 100 ? _usarPocao : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Usar Poção'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}