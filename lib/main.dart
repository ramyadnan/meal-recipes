import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/screens/tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 79, 46, 34),
  ),
  textTheme: GoogleFonts.leagueSpartanTextTheme(),
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 79, 46, 34),
  ),
  textTheme: GoogleFonts.leagueSpartanTextTheme(),
); 

void main() {
  runApp(
    const ProviderScope(
      child: App()
    )
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: darkTheme,
      theme: theme,
      home: const TabsScreen(),
    );
  }
}