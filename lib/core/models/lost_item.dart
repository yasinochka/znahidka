import 'package:flutter/material.dart';

/// Тип оголошення: річ загублено або знайдено.
enum ItemType { lost, found }

/// Модель оголошення про загублену або знайдену річ.
class LostItem {
  final String id;
  final String title;
  final ItemType type;
  final String category;
  final String location;
  final String date;
  final int views;
  final Color imageColor;

  const LostItem({
    required this.id,
    required this.title,
    required this.type,
    required this.category,
    required this.location,
    required this.date,
    required this.views,
    required this.imageColor,
  });
}
