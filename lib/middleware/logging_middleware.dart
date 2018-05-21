import 'package:redux/redux.dart';
import 'package:chips_shop/models/models.dart';

class LoggingMiddleware extends MiddlewareClass<AppState> {

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    var stateBefore = store.state.toString();
    print("Last store $stateBefore");
    print("Dispatching $action");
    next(action);
    var stateAfter = store.state.toString();
    print("Next store $stateAfter");
  }

}