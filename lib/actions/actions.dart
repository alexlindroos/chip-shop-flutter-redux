import 'package:chips_shop/models/models.dart';

class BuyItemsAction {
  final List<ChipItem> items;
  BuyItemsAction(this.items);
}

class AddItemAction {
  final ChipItem item;
  AddItemAction(this.item);
}

class DeleteItemAction {
  final ChipItem item;
  DeleteItemAction(this.item);
}

