import 'package:flutter/material.dart';
import 'package:chips_shop/theme/themes.dart';
import 'package:chips_shop/app/chip_shop.dart';
import 'package:chips_shop/reducers/items_reducers.dart';
import 'package:chips_shop/models/app_state.dart';
import 'package:chips_shop/localization.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:chips_shop/middleware/logging_middleware.dart';


void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final store = new Store<AppState>(
    appStateReducer,
    middleware: [
      new LoggingMiddleware()
    ],
    initialState: new AppState(),
  );

  MyApp();

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
        store: store,
        child: new MaterialApp(
          title: new ChipShopLocalizations().appTitle,
          theme: lightTheme.data,
          localizationsDelegates: [
          new ChipShopLocalizationsDelegate(),
          ],
          home: new ChipShop(),
        )
    );
  }
}
