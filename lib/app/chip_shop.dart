import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:chips_shop/models/models.dart';
import 'package:chips_shop/data/chipz_data.dart';
import 'package:chips_shop/actions/actions.dart';
import 'package:chips_shop/ui/shopping_cart.dart';

class ChipShop extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new ChipShopState();
  }
}

class ChipShopState extends State<ChipShop> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<ChipItem> chips = [];

  @override
  void initState() {
    super.initState();
    chips = getAllChipsData();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder(
        builder: (context, Store<AppState> store) {
          return new Scaffold(
            key: scaffoldKey,
            appBar: new AppBar(
                title: new Text("Chip Shop")
            ),
            floatingActionButton: new FloatingActionButton(
              onPressed: () => _openShoppingCart(),
              child: new Icon(Icons.shopping_cart,
                color: Theme.of(context).indicatorColor,
              ),
            ),
            body: _chipCatalog(chips),
          );
        }
    );
  }

  _openShoppingCart() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new ShoppingCart()),
    );
  }

  Widget _chipCatalog(List<ChipItem> chips) {
    return new GridView.count(
      primary: false,
      shrinkWrap: true,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      padding: const EdgeInsets.all(5.0),
      crossAxisCount: 2,
      children: new List.generate(chips.length, (index)  {
        return _itemCard(chips[index]);
      }
      ),
    );
  }

  Widget _itemCard(ChipItem chip) {
    return new StoreBuilder(
        builder: (context, Store<AppState> store) {
          return new Card(
            elevation: 2.0,
            color: Theme.of(context).primaryColor,
            child: new InkWell(
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: new Image(
                              image: new AssetImage(chip.pic)
                          ),
                        )
                    ),
                    new Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: new Divider(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    new Text(
                      chip.flavour,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Theme.of(context).indicatorColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    new Text(
                      "${chip.price.toString()}€",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Theme.of(context).indicatorColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: new MaterialButton(
                        color: Colors.green,
                        onPressed: () {_itemAddedToCart(store, chip);},
                        child: new Text("Buy now"),
                      ),
                    )
                  ]
              ),
              onTap: () {
                print("Inkwell tapped");
              },
            ),
          );
        }
    );
  }

  _itemAddedToCart(Store<AppState> store, ChipItem chip) {
    store.dispatch(AddItemAction(chip));
    scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          content: new Text("${chip.name}: ${chip.flavour} added"),
        )
    );
  }

}