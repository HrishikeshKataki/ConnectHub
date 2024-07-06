import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});
  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  Color favIcon = Colors.redAccent;
  IconData fav = Icons.favorite_border;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            if (favIcon == Colors.redAccent) {
              favIcon = Colors.red;
              fav = Icons.favorite;
            } else {
              favIcon = Colors.redAccent;
              fav = Icons.favorite_border;
            }
          });
        },
        icon: Icon(
          fav,
          color: favIcon,
          size: 28,
        ));
  }
}
