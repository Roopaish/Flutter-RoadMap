import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const routeName = '/shop-app/orders';

//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   var _isLoading = false;
//   var _isEmpty = false;

//   @override
//   void initState() {
  // Future.delayed(Duration.zero).then((_) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  //   setState(() {
  //     _isLoading = false;
  //     _isEmpty = false;
  //   });
  // }).catchError((error) {
  //   setState(() {
  //     _isLoading = false;
  //     _isEmpty = true;
  //   });
  // });

//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: FutureBuilder(
            future: Provider.of<Orders>(context, listen: false)
                .fetchAndSetOrders(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (dataSnapshot.error != null) {
                  // Do error handling
                  return Center(
                    child: Text('No orders placed yet!'),
                  );
                } else {
                  return Consumer<Orders>(
                    builder: (ctx, orderData, child) => ListView.builder(
                      itemCount: orderData.orders.length,
                      itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                    ),
                  );
                }
              }
            },
          ),
        )
        //  _isEmpty
        //     ? Center(child: Text('No orders placed yet!'))
        //     : _isLoading
        //         ? Center(
        //             child: CircularProgressIndicator(),
        //           )
        //         : ListView.builder(
        //             itemCount: orderData.orders.length,
        //             itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
        //           ),
        );
  }
}
