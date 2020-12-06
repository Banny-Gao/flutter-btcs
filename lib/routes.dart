import './widgets/index.dart';
import './app.dart';

final routes = {
  '/': (context) => App(),
  '/login': (context) => Login(),
  '/groupBooking': (context) => GroupBooking(),
  '/owner': (context) => Owner(),
};
