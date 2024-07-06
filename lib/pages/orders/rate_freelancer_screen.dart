import 'package:connecthub/utils/my_colors.dart';
import 'package:connecthub/utils/txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateFreelancerScreen extends StatefulWidget {
  final String freelancerName;
  const RateFreelancerScreen({super.key, required this.freelancerName});

  @override
  _RateFreelancerScreenState createState() => _RateFreelancerScreenState();
}

class _RateFreelancerScreenState extends State<RateFreelancerScreen> {
  double _rating = 0.0;
  String _comment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text(
          'Rate and Review',
          style: txt.appBarTitle,
        ),
        iconTheme: const IconThemeData(color: white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate ${widget.freelancerName}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 40.0,
                  glow: false,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  'Rating: $_rating',
                  style: txt.fieldDark,
                )
              ],
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Leave a comment:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Leave a Review here!',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _comment = value;
                });
              },
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Review submitted Successfully!'),
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
                'Submit',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
