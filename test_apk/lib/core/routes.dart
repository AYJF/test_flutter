import 'models/route_model.dart';

class RoutesList {
  static List<RouteModel> _routes = [];

  static get routes {
    return _routes;
  }

  static void add(RouteModel route) {
    if (!_routes.contains(route)) {
      _routes.add(route);
    }
  }
}
