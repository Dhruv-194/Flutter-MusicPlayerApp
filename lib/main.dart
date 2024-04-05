import 'package:flutter/material.dart';
import 'package:minimal_music_player_app/models/playlist_provider.dart';
import 'package:minimal_music_player_app/pages/homepage.dart';
import 'package:minimal_music_player_app/pages/trysongs1.dart';
import 'package:minimal_music_player_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
      create: (context) => PlaylistProvider(),
      ),
    ],
    child: const MyApp(),
    )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home:const TrySongs1(),
     theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}