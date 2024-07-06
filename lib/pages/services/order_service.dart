import 'package:connecthub/pages/services/payment_screen.dart';
import 'package:connecthub/utils/my_colors.dart';
import 'package:connecthub/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class OrderServiceScreen extends StatefulWidget {
  final String serviceId;
  final String freelancerId;

  const OrderServiceScreen({
    super.key,
    required this.serviceId,
    required this.freelancerId,
  });

  @override
  _OrderServiceScreenState createState() => _OrderServiceScreenState();
}

class _OrderServiceScreenState extends State<OrderServiceScreen> {
  late String serviceName;
  late double servicePrice;
  late double tax;
  late double totalPrice;
  late DateTime deliveryDate;
  late String freelancerName;
  late String freelancerEmail;
  late String freelancerPhone;

  @override
  void initState() {
    super.initState();
    // fetch service and freelancer details from API or local data
    serviceName = "Web Development";
    servicePrice = 99.99;
    tax = 9.99;
    totalPrice = servicePrice + tax;
    deliveryDate = DateTime.now().add(const Duration(days: 7));
    freelancerName = "Hrishikesh Kataki";
    freelancerEmail = "john@example.com";
    freelancerPhone = "+1 555 555 5555";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Service"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to freelancer profile
                  },
                  child: const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage("assets/beard.jpg"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        freelancerName,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                scrollable: true,
                                title: const Text('Contact Me'),
                                content: SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.1,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {
                                            Clipboard.setData(const ClipboardData(
                                                text:
                                                    'hrishikeshkataki10@gmail.com'));
                                          },
                                          style: OutlinedButton.styleFrom(
                                              shape: LinearBorder.start(
                                                  side: const BorderSide(
                                                      width: 3)),
                                              alignment: Alignment.centerLeft,
                                              textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500)),
                                          child: const Text('Email'),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            Clipboard.setData(
                                                const ClipboardData(
                                                    text: '1234567890'));
                                          },
                                          style: OutlinedButton.styleFrom(
                                              shape: LinearBorder.start(
                                                  side: const BorderSide(
                                                      width: 3)),
                                              alignment: Alignment.centerLeft,
                                              textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500)),
                                          child: const Text('Phone'),
                                        )
                                      ]),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 3,
                              fixedSize: const Size(150, 42),
                              foregroundColor: white,
                              backgroundColor: primary),
                          child: const Text(
                            'Contact Me',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Service: $serviceName",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Service Description: Make a Website for a Freelancing platform using flutter to go along with the already existing mobile app",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              "Summary",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text("Service Price: \$${servicePrice.toStringAsFixed(2)}"),
            Text("Tax: \$${tax.toStringAsFixed(2)}"),
            Text("Total: \$${totalPrice.toStringAsFixed(2)}"),
            Text("Delivery Date: ${deliveryDate.toString()}"),
            const Spacer(),
            CustomButton(
                buttonText: 'Proceed to Payment',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaymentForm()));
                })
          ],
        ),
      ),
    );
  }
}
