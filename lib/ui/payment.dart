import 'package:flutter/material.dart';
import 'package:chips_shop/models/models.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:chips_shop/actions/actions.dart';
import 'package:chips_shop/app/chip_shop.dart';

class PaymentPage extends StatefulWidget{

  double price = 0.0;

  @override
  State<StatefulWidget> createState() {
    return new PaymentPageState();
  }
}

class PaymentPageState extends State<PaymentPage> {

  @override
  Widget build(BuildContext context) {

    return new StoreBuilder(
        builder: (context, Store<AppState> store) {

          List<ChipItem> chips = store.state.items;

          if(widget.price == 0.0) {
            chips.forEach((ChipItem c) {
              if(c == null) {
                return;
              } else {
                widget.price += c.price;
              }
            });
          }

          return new Scaffold(
            appBar: new AppBar(
                title: new Text("Payment")
            ),
            body: new Column(
                children: <Widget>[
                  _paymentView(store.state.items),
                  new Text(
                      "Total price: ${format(widget.price).toString()}€",
                    style: new TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new FlatButton(
                        color: Theme.of(context).buttonColor,
                        onPressed: () {
                          store.dispatch(BuyItemsAction(store.state.items));
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new ChipShop()),
                          );
                        } ,
                        child: new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                              "Buy",
                            style: new TextStyle(
                              color: Theme.of(context).indicatorColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0
                            ),
                          ),
                        ),
                    ),
                  ),
                ],
            ),
          );
        }
    );
  }

  _paymentView(List<ChipItem> chips) {
    return new Flexible(
      child: new ListView.builder(
        itemCount: chips.length,
        itemBuilder: (BuildContext context, int index) {
          return _paymentListItem(chips[index]);
        },
      ),
    );
  }

  Widget _paymentListItem(ChipItem chip) {
    return new ListTile(
      leading: new Image.asset(chip.pic),
      title: new Text(
        "${chip.name}: ${chip.flavour}",
        style: new TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
      subtitle: new Text(
        "${chip.price.toString()}€",
        style: new TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }
}

