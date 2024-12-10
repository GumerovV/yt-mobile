import 'package:flutter/material.dart';

SnackBar errorSnackBar(String error) {
  return SnackBar(
    content: Center(
      child: Text(
        error,  // Выводим сообщение ошибки
        style: const TextStyle(color: Colors.white),
      ),
    ),
    backgroundColor: Colors.redAccent,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    duration: const Duration(seconds: 5),
  );
}