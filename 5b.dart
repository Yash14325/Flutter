// 5b.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(create: (_) => CartProvider(), child: CartDemo()),
    );

class CartDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Cart Demo'),
              bottom: TabBar(tabs: [Tab(text: 'setState'), Tab(text: 'Provider')]),
            ),
            body: TabBarView(children: [LocalCart(), GlobalCart()]),
          ),
        ),
      );
}

/* 1) Local cart using setState */
class LocalCart extends StatefulWidget {
  @override
  _LocalCartState createState() => _LocalCartState();
}

class _LocalCartState extends State<LocalCart> {
  int apples = 0;
  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Apples: $apples', style: TextStyle(fontSize: 22)),
          SizedBox(height: 8),
          ElevatedButton(onPressed: () => setState(() => apples++), child: Text('Add Apple')),
        ]),
      );
}

/* 2) Global cart using Provider */
class CartProvider extends ChangeNotifier {
  int items = 0;
  void add() {
    items++;
    notifyListeners();
  }
}

class GlobalCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = context.watch<CartProvider>().items;
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Cart Items: $items', style: TextStyle(fontSize: 22)),
        SizedBox(height: 8),
        ElevatedButton(onPressed: () => context.read<CartProvider>().add(), child: Text('Add Item')),
      ]),
    );
  }
}
