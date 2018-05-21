import 'package:meta/meta.dart';
import 'package:chips_shop/models/chip_item.dart';
import 'package:chips_shop/models/models.dart';

@immutable
class AppState {
  final List<ChipItem> items;

  AppState({
    this.items = const [],
  });

  AppState copyWith({
    List<ChipItem> items,
  }) {
    return new AppState(
      items: items ?? this.items,
    );
  }

  @override
  int get hashCode =>
      items.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              items == other.items;

  @override
  String toString() {
    return 'AppState{items: $items}';
  }
}
