import 'package:flutter/material.dart';
import 'package:shopApp/providers/auth.dart';
import 'package:shopApp/providers/cart.dart';
import 'package:shopApp/providers/orders.dart';
import 'package:shopApp/screens/auth_screen.dart';
import 'package:shopApp/screens/cart_screen.dart';
import 'package:shopApp/screens/edit_product_screen.dart';
import 'package:shopApp/screens/orders_screen.dart';
import 'package:shopApp/screens/product_detail_screen.dart';
import 'package:shopApp/screens/products_overview_screen.dart';
import 'package:shopApp/screens/splash_screen.dart';
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
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(auth.token, auth.userId,
              previousOrders == null ? [] : previousOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyShop',
            theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                fontFamily: 'Lato'),
            home: auth.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSanpshot) =>
                        authResultSanpshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            }),
      ),
    );
  }
}
