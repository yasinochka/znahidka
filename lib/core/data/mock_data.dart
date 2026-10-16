import 'package:flutter/material.dart';

import '../models/lost_item.dart';

/// Hardcoded-дані замість реального бекенду (без бізнес-логіки).
class MockData {
  MockData._();

  static const String userFirstName = 'Ліза';
  static const String userLastName = 'Ясінська';
  static const String userName = '$userFirstName $userLastName';
  static const String userInitials = 'ЛЯ';
  static const String userEmail = 'yelyzavetayasinska@gmail.com';
  static const String userPhone = '+380 50 123 45 67';

  static const int newToday = 48;
  static const int lostCount = 1204;
  static const int foundCount = 986;
  static const int returnedCount = 12340;

  static const List<String> quickCategories = ['Документи', 'Ключі', 'Тварини'];

  static const List<LostItem> items = [
    LostItem(
      id: '1',
      title: 'Коричневий шкіряний гаманець',
      type: ItemType.lost,
      category: 'Гаманці та сумки',
      location: 'Львів, вул. Городоцька',
      date: 'Сьогодні, 09:40',
      views: 18,
      imageColor: Color(0xFFEDE6DC),
    ),
    LostItem(
      id: '2',
      title: 'Зв’язка ключів з брелоком',
      type: ItemType.found,
      category: 'Ключі',
      location: 'Парк Стрийський, біля фонтану',
      date: 'Вчора, 18:15',
      views: 42,
      imageColor: Color(0xFFE4E2EE),
    ),
    LostItem(
      id: '3',
      title: 'Рудий кіт «Сімба»',
      type: ItemType.lost,
      category: 'Тварини',
      location: 'Сихів, вул. Червоної Калини',
      date: '29 вер., 20:00',
      views: 133,
      imageColor: Color(0xFFEDE4DA),
    ),
    LostItem(
      id: '4',
      title: 'Смартфон у фіолетовому чохлі',
      type: ItemType.found,
      category: 'Гаджети',
      location: 'Трамвай №2, зупинка «Шевченка»',
      date: '29 вер., 13:20',
      views: 27,
      imageColor: Color(0xFFE6E3EF),
    ),
    LostItem(
      id: '5',
      title: 'Студентський квиток ЛП',
      type: ItemType.lost,
      category: 'Документи',
      location: 'Корпус 5 НУ «ЛП»',
      date: '28 вер., 11:05',
      views: 56,
      imageColor: Color(0xFFEAE6DE),
    ),
    LostItem(
      id: '6',
      title: 'Синя парасолька',
      type: ItemType.found,
      category: 'Аксесуари',
      location: 'Кав’ярня на пл. Ринок',
      date: '27 вер., 16:30',
      views: 11,
      imageColor: Color(0xFFDFE3EA),
    ),
  ];
}
