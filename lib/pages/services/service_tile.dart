import 'package:connecthub/pages/services/service_details.dart';
import 'package:connecthub/utils/my_colors.dart';
import 'package:connecthub/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../utils/layout.dart';
import "../../utils/txt.dart";

class ServiceTile extends StatefulWidget {
  final String serviceID;
  final String serviceTitle;
  final String serviceDesc;
  final String uploadedBy;
  final String uploaderId;
  final String serviceImage;
  final int servicePrice;

  const ServiceTile(
      {super.key,
      required this.serviceID,
      required this.serviceTitle,
      required this.serviceDesc,
      required this.uploadedBy,
      required this.uploaderId,
      required this.serviceImage,
      required this.servicePrice});

  @override
  State<ServiceTile> createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
      ),
      child: Card(
        surfaceTintColor: sbg,
        elevation: layout.elevation,
        shadowColor: primary,
        child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ServiceDetails(
                            title: widget.serviceTitle,
                            desc: widget.serviceDesc,
                            image: widget.serviceImage,
                            uploadedBy: widget.uploadedBy,
                            price: widget.servicePrice,
                            uploaderId: widget.uploaderId,
                          )));
            },
            contentPadding: const EdgeInsets.all(layout.padding / 2),
            leading: Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1),
                ),
              ),
              child: Image.asset(
                widget.serviceImage,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: layout.padding / 4),
              child: Text(
                widget.serviceTitle,
                style: txt.subTitleDark,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: layout.padding / 4),
                    child: Text(
                      widget.serviceDesc,
                      style: txt.body2Dark,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('From '),
                      Text(
                        '₹${widget.servicePrice.toString()}',
                        style: txt.subTitleDark,
                      ),
                    ],
                  )
                ]),
            trailing: const LikeButton()),
      ),
    );
  }
}
