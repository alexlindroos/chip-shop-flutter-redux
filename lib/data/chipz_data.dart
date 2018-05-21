import 'package:chips_shop/models/chip_item.dart';

List<ChipItem> _allChipsData = [
  ChipItem("1", "Pringles", "Paprika", 2.35, "assets/pringles1.png"),
  ChipItem("2", "Pringles", "Peri Peri", 2.49, "assets/pringles2.png"),
  ChipItem("3", "Pringles", "Honey Mustard", 1.99, "assets/pringles3.png"),
  ChipItem("4", "Pringles", "Sour Cream & Onion", 2.49, "assets/pringles4.png"),
  ChipItem("5", "Pringles", "Original", 1.99, "assets/pringles5.png"),
  ChipItem("6", "Lays", "Classic", 1.75, "assets/lays1.png"),
  ChipItem("7", "Lays", "Flamin' Hot", 1.85, "assets/lays2.png"),
  ChipItem("8", "Lays", "India's Magic Masala", 1.95, "assets/lays3.png"),
  ChipItem("9", "Lays", "Limón", 2.15, "assets/lays4.png"),
  ChipItem("10", "Lays", "Bolognese Originale", 2.35, "assets/lays5.png"),
];

List<ChipItem> getAllChipsData() {
  return _allChipsData;
}