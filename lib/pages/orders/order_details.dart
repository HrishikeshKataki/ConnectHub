import 'package:connecthub/utils/txt.dart';
import 'package:flutter/material.dart';
import 'package:connecthub/pages/orders/order.dart';
import 'package:connecthub/pages/orders/rate_freelancer_screen.dart';
import 'package:connecthub/utils/my_colors.dart';

class OrderDetails extends StatelessWidget {
  final Order order;

  const OrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(order.serviceName, style: txt.appBarTitle),
        iconTheme: const IconThemeData(color: white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Freelancer: ${order.freelancerName}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status: ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  order.status,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: order.status == 'Completed'
                        ? Colors.green
                        : order.status == 'In Progress'
                            ? Colors.orange
                            : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Delivery Date: ${order.deliveryDate.toString().split(' ').first}',
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: secondaryText),
            ),
            const SizedBox(height: 24),
            const Text(
              'Details:',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              order.details,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const SizedBox(height: 16),
            const Text(
              'Payment Details:',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount:',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: secondaryText),
                ),
                Text(
                  '\$250',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Method:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: secondaryText,
                  ),
                ),
                Text(
                  'Credit Card',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (order.status == 'Completed')
              ElevatedButton(
                onPressed: () {
                  // Navigate to the RateFreelancerScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RateFreelancerScreen(
                        freelancerName: order.freelancerName,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Rate Freelancer',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
