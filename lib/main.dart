import 'package:flutter/material.dart';
import 'package:flutter_yt_v2/router.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
  runApp(MyApp(router: AppRouter()));  // Создаем единственный экземпляр AppRouter
}

class MyApp extends StatelessWidget {
  final AppRouter router;
  
  const MyApp({super.key, required this.router});  // Используем super.key

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "YouTube 2.0",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 31, 29, 43),
        primaryColor: const Color.fromARGB(255, 255, 118, 82),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 255, 118, 82),
          secondary: const Color.fromARGB(255, 255, 118, 82),
        ),
        textTheme: const TextTheme().copyWith(
          bodySmall: const TextStyle(color: Colors.white),
          bodyMedium: const TextStyle(color: Colors.white),
          bodyLarge: const TextStyle(color: Colors.white),
          labelLarge: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true, // Если нужно заполнить фон
          fillColor: Colors.grey[800], // Цвет фона
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.transparent), // Цвет рамки, когда TextField не в фокусе
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Color.fromARGB(255, 255, 118, 82)), // Цвет рамки при фокусе
          ),
          labelStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal), // Цвет текста лейбла
          hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),  // Цвет текста подсказки
        ),
      ),
      onGenerateRoute: router.onGenerateRoute,  // Используем метод onGenerateRoute
    );
  }
}
