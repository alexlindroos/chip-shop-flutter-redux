import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chips_shop/models/models.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:chips_shop/actions/actions.dart';
import 'package:chips_shop/ui/payment.dart';

class ShoppingCart extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new ShoppingCartState();
  }

}

class ShoppingCartState extends State<ShoppingCart> {

  double price = 0.0;

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder(
        builder: (context, Store<AppState> store) {
          return new Scaffold(
            appBar: new AppBar(
                title: new Text("Shopping Cart")
            ),
            floatingActionButton: new FloatingActionButton(
              onPressed: () => _openCheckout(),
              child: new Icon(Icons.credit_card,
                color: Theme.of(context).indicatorColor,
              ),
            ),
            body: _chipCatalog(store.state.items, store),
          );
        }
    );
  }

  Widget _chipCatalog(List<ChipItem> chips, Store<AppState> store) {

    if(price == 0.0) {
      chips.forEach((ChipItem c) {
        price += c.price;
      });
    }
    return new SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          _cartInfo(chips,store,price),
          GridView.count(
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
          )
        ],
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
                    ]
                ),
                onLongPress: () {_showDialog(chip, store);}
            ),
          );
        }
    );
  }

  Widget _cartInfo(List<ChipItem> chips, Store<AppState> store, double price) {
    return new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Container(
          alignment: Alignment.center,
          color: Theme.of(context).accentColor,
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              children: <Widget>[
                Text(
                  "Quantity: ${store.state.items.length.toString()}",
                  style: new TextStyle(
                    color: Theme.of(context).indicatorColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  "Price: ${format(price)}€",
                  style: new TextStyle(
                    color: Theme.of(context).indicatorColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  Future<Null> _showDialog(ChipItem chip, Store<AppState> store) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Delete item from the shopping cart'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Are you sure you want to delete item from the shopping cart?'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(onPressed: () {
              store.dispatch(DeleteItemAction(chip));
              Navigator.of(context).pop();
            },
                child: new Text("Yes")
            ),
            new FlatButton(
                onPressed: () {Navigator.of(context).pop();
                },
                child: new Text("No")
            ),
          ],
        );
      },
    );
  }

  _openCheckout() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new PaymentPage()),
    );
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }
}