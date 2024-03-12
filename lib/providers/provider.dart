
import 'package:bukizz_delivery/mvvm/viewModels/Auth/authViewModel.dart';
import 'package:bukizz_delivery/mvvm/viewModels/orders/orders.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'bottom_nav_bar_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => Orders()),
];
