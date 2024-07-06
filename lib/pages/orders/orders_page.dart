import 'package:connecthub/pages/orders/order_details.dart';
import 'package:connecthub/utils/my_colors.dart';
import 'package:connecthub/utils/txt.dart';
import 'package:flutter/material.dart';
import 'package:connecthub/pages/orders/order.dart';

class OrdersPage extends StatelessWidget {
  final List<Order> _orders = [
    Order(
      serviceName: 'Graphic Design',
      freelancerName: 'John Doe',
      status: 'Completed',
      deliveryDate: DateTime.now().add(const Duration(days: 3)),
      details: 'Design a logo for a new startup',
    ),
    Order(
      serviceName: 'Web Development',
      freelancerName: 'Jane Smith',
      status: 'In Progress',
      deliveryDate: DateTime.now().add(const Duration(days: 7)),
      details: 'Develop a website for a small business',
    ),
    Order(
      serviceName: 'Content Writing',
      freelancerName: 'Michael Johnson',
      status: 'Pending',
      deliveryDate: DateTime.now().add(const Duration(days: 14)),
      details: 'Write articles for a blog',
    ),
    Order(
      serviceName: 'Social Media Management',
      freelancerName: 'Emily Davis',
      status: 'Completed',
      deliveryDate: DateTime.now().add(const Duration(days: 10)),
      details: 'Manage social media accounts for a brand',
    ),
    Order(
      serviceName: 'Video Editing',
      freelancerName: 'William Brown',
      status: 'In Progress',
      deliveryDate: DateTime.now().add(const Duration(days: 5)),
      details: 'Edit a promotional video for a product',
    ),
    Order(
      serviceName: 'SEO Optimization',
      freelancerName: 'Sophia Wilson',
      status: 'Pending',
      deliveryDate: DateTime.now().add(const Duration(days: 21)),
      details: 'Optimize a website for search engines',
    ),
  ];

  OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Orders', style: txt.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
          itemCount: _orders.length,
          itemBuilder: (context, index) {
            final order = _orders[index];
            return Card(
              surfaceTintColor: sbg,
              elevation: 3,
              shadowColor: primary,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: order.status == 'Completed'
                      ? Colors.green
                      : order.status == 'In Progress'
                          ? Colors.amber
                          : Colors.red,
                  child: Icon(
                    order.status == 'Completed'
                        ? Icons.check
                        : order.status == 'In Progress'
                            ? Icons.hourglass_bottom
                            : Icons.hourglass_top,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  '${order.serviceName} by ${order.freelancerName}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status: ${order.status}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      'Delivery Date: ${order.deliveryDate.toString().split(' ').first}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: primary,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetails(order: order),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
