import 'package:connecthub/utils/txt.dart';
import 'package:flutter/material.dart';
import 'package:connecthub/utils/my_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewWidget extends StatefulWidget {
  final String commentId;
  final String commenterId;
  final String commenterName;
  final String commentBody;
  final String commenterImageUrl;
  final double commenterRating;

  const ReviewWidget(
      {super.key,
      required this.commentId,
      required this.commenterId,
      required this.commenterName,
      required this.commentBody,
      required this.commenterImageUrl,
      required this.commenterRating});

  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  final List<Color> _colors = [
    Colors.black,
    Colors.black12,
    Colors.black26,
    Colors.black38,
    Colors.black45
  ];

  @override
  Widget build(BuildContext context) {
    _colors.shuffle();
    return SizedBox(
      width: 200,
      child: Card(
        surfaceTintColor: sbg,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(widget.commenterImageUrl),
              ),
              const SizedBox(height: 8),
              Text(
                widget.commenterName,
                style: txt.titleDark,
              ),
              RatingBarIndicator(
                itemBuilder: (context, index) => const Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                ),
                direction: Axis.horizontal,
                rating: widget.commenterRating,
                unratedColor: Colors.grey[400],
                itemCount: 5,
                itemPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                itemSize: 22,
              ),
              const SizedBox(height: 4),
              Text(
                widget.commentBody,
                style: txt.body2Dark,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
