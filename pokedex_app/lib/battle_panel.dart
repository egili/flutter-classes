import 'package:flutter/material.dart';
import 'pokemon.dart';
import 'stat_bar.dart';
import 'pokemon.dart';

class BattlePanel extends StatefulWidget {
  final Pokemon pokemon;

  const BattlePanel({super.key, required this.pokemon});

  @override
  State<BattlePanel> createState() => _BattlePanelState();
}

class _BattlePanelState extends State<BattlePanel> {
  int hp = 100;
  int xp = 0;
  late int level;

  @override
  void initState() {
    super.initState();
    level = widget.pokemon.level;
  }

  Color get hpColor {
    if (hp > 60) return Colors.green;
    if (hp > 30) return Colors.yellow;
    return Colors.red;
  }

  String get statusMessage {
    if (hp == 0) return '${widget.pokemon.name} desmaiou!';
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Nível $level',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            StatBar(label: 'HP', value: hp, maxValue: 100, color: hpColor),
            StatBar(label: 'XP', value: xp, maxValue: 100, color: Colors.blue),

            if (statusMessage.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                statusMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: hp > 0 ? _atacar : null,
                    child: const Text('Atacar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: hp < 100 ? _usarPocao : null,
                    child: const Text('Usar Poção'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, level);
              },
              child: const Text('Encerrar Batalha'),
            ),
          ],
        ),
      ),
    );
  }
}