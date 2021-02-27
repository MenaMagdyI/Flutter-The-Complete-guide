import 'package:flutter/material.dart';
import 'package:shopApp/providers/cart.dart';
import 'package:shopApp/providers/orders.dart';
import 'package:shopApp/screens/cart_screen.dart';
import 'package:shopApp/screens/edit_product_screen.dart';
import 'package:shopApp/screens/orders_screen.dart';
import 'package:shopApp/screens/product_detail_screen.dart';
import 'package:shopApp/screens/products_overview_screen.dart';
import 'package:shopApp/screens/user_products.dart';
import 'package:shopApp/widgets/user_product_item.dart';
import './providers/products.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Lato'),
          home: ProductOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          }),
    );
  }
}
