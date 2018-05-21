import 'package:chips_shop/actions/actions.dart';
import 'package:chips_shop/models/chip_item.dart';
import 'package:chips_shop/models/app_state.dart';

List<ChipItem> itemsReducer(List<ChipItem> items, action) {
  if (action is AddItemAction) {
    return new List.from(items)..add(action.item);
  } if (action is DeleteItemAction) {
    return new List.from(items)..remove(action.item);
  } if (action is BuyItemsAction) {
    return new List.from(items)..clear();
  } else {
    return items;
  }
}

AppState appStateReducer(AppState state, action) => new AppState(
    items: itemsReducer(state.items, action)
);