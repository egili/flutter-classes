// Eliseu Pereira Gili - 25009281
// Pietra Façanha Bortolato - 25002436

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Importação do Firebase
import 'firebase_options.dart'; // Importação das suas credenciais
import 'home_screen.dart';

void main() async {
  // Garante que os plugins do Flutter estejam prontos antes de iniciar o Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase com as configurações do seu projeto
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}