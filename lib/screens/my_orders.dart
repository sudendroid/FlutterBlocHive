import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psi/cubit/orders_cubit.dart';
import 'package:psi/models/order.dart';

class MyOrders extends StatefulWidget {
  static const String ROUTE = "/myOrders";

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    BlocProvider.of<OrdersCubit>(context).getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
      ),
      body: _getPageView(),
    );
  }

  Widget _getPageView() {
    return BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadingOrders) {
            return _buildLoadingView();
          } else if (state is NoOrders) {
            return _buildEmptyView();
          } else if (state is OrdersLoaded) {
            return _buildOrderListView(state.orders);
          } else {
            return _buildEmptyView();
          }
        });
  }

  Widget _buildLoadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Text("Order list is empty!"),
    );
  }

  Widget _buildOrderListView(List<Order> orders) {
    return ListView.separated(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return _buildOrderItemView(orders[index]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildOrderItemView(Order order) {
    return ListTile(
      title: Text("Order No - ${order.key}"),
      subtitle: Text("Total Items - ${order.items.length}"),
      trailing: Text("Billing Amt - ₹${order.total}"),
    );
  }
}
