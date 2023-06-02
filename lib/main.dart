import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_audio_player/features/tracks_screen/view/tracks_screen.dart';
import 'routes/navigate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'itunes demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: TracksScreen.name,
      getPages: Navigate.routes,
    );
  }
}
