import 'package:connecthub/pages/profile_edit/freelancer_profile.dart';
import 'package:connecthub/pages/services/order_service.dart';
import 'package:connecthub/pages/services/services.dart';
import 'package:connecthub/utils/my_colors.dart';
import 'package:connecthub/utils/txt.dart';
import 'package:connecthub/widgets/Review_widget.dart';
import 'package:connecthub/widgets/like_button.dart';
import 'package:connecthub/pages/services/service_tile.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ServiceDetails extends StatefulWidget {
  String title;
  String desc;
  String image;
  String uploadedBy;
  String uploaderId;
  int price;
  ServiceDetails(
      {super.key,
      required this.title,
      required this.desc,
      required this.image,
      required this.uploadedBy,
      required this.uploaderId,
      required this.price});

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  List<String> serviceInfo = [
    'Delivered within 3 business days',
    '5 pages of high-quality content',
    '100% satisfaction guarantee',
  ];

  List<Map<String, dynamic>> faqList = [
    {
      'question': 'What is included in the service?',
      'answer': 'Answer to the first question',
    },
    {
      'question': 'How long does it take to deliver the job?',
      'answer': 'Answer to the second question',
    },
    {
      'question': 'What is the quality of the content?',
      'answer': 'Answer to the third question',
    },
    {
      'question': 'Can I request revisions?',
      'answer': 'Answer to the fourth question',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: 250,
            toolbarHeight: 50,
            backgroundColor: Colors.transparent,
            actions: const [
              Padding(padding: EdgeInsets.only(right: 10), child: LikeButton())
            ],
            flexibleSpace: Image(image: AssetImage(widget.image)),
            iconTheme: const IconThemeData(color: white),
          ),
          SliverList(
              delegate: SliverChildListDelegate.fixed([
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 10, right: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      textAlign: TextAlign.left,
                      style: txt.titleDark,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.desc,
                      textAlign: TextAlign.left,
                      style: txt.body2Dark,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Price: ',
                          textAlign: TextAlign.left,
                          style: txt.floatingLabelDark,
                        ),
                        Text(
                          '₹${widget.price.toString()}',
                          style: txt.titleDark,
                        ),
                      ],
                    ),
                  ]),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => FreelancerProfile(
                              freelancerId: '1',
                              account: false,
                            ))));
              },
              tileColor: secondary,
              leading: CircleAvatar(
                child: Image.asset('assets/beard.jpg'),
              ),
              title: Text(
                widget.uploadedBy,
                style: txt.titleDark,
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: white,
                size: 30,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 20, 8, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Included in Service',
                    style: txt.titleDark,
                  ),
                ],
              ),
            ),
            Card(
              elevation: 3,
              surfaceTintColor: sbg,
              child: Column(
                children: [
                  Column(
                    children: serviceInfo
                        .map((service) => Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const Icon(Icons.check_circle,
                                      color: Colors.green),
                                  const SizedBox(width: 8),
                                  Flexible(
                                      child: Text(
                                    service,
                                    style: const TextStyle(fontSize: 18),
                                  ))
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, bottom: 5),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primary, foregroundColor: sbg),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const OrderServiceScreen(
                                            serviceId: '1',
                                            freelancerId: '1')));
                          },
                          child: const Text(
                            'Buy Now',
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 10, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Frequently Asked Questions',
                    style: txt.titleDark,
                  ),
                  const SizedBox(height: 8),
                  ExpansionPanelList(
                    expandIconColor: primary,
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        faqList[index].containsKey('isExpanded')
                            ? faqList[index]['isExpanded'] =
                                !faqList[index]['isExpanded']
                            : faqList[index]['isExpanded'] = true;
                      });
                    },
                    children: faqList
                        .map<ExpansionPanel>((Map<String, dynamic> item) {
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(
                              item['question'],
                              style: txt.body2Dark,
                            ),
                          );
                        },
                        body: ListTile(
                          title: Text(
                            item['answer'],
                            style: txt.body2Dark,
                          ),
                        ),
                        isExpanded: item.containsKey('isExpanded')
                            ? item['isExpanded']
                            : false,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8, top: 12, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ratings and Reviews',
                    style: txt.titleDark,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // Replace with the number of reviews
                itemBuilder: (context, index) {
                  return ReviewWidget(
                      commentId: '$index',
                      commenterId: '$index',
                      commenterName: 'User Name $index',
                      commentBody:
                          'Comment Review Comment Review Comment Review $index',
                      commenterImageUrl: 'assets/beard.jpg',
                      commenterRating: 4);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recommended for you',
                    style: txt.titleDark,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Services(srvCategory: 'recommend')));
                      },
                      child: const Text(
                        'See More',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: primary),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    10, // Replace with the number of recommended services
                itemBuilder: (context, index) {
                  return SizedBox(
                      width: MediaQuery.sizeOf(context).width * 1,
                      child: ServiceTile(
                        serviceID: '$index',
                        serviceTitle: 'Service Title $index',
                        serviceDesc:
                            'Short Service Description $index Short Service Description',
                        uploadedBy: '$index',
                        serviceImage: 'assets/portrait.jpg',
                        servicePrice: index * 1000 + 1000,
                        uploaderId: '$index',
                      ));
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8, top: 10, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'People also Viewed',
                    style: txt.titleDark,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    10, // Replace with the number of recommended services
                itemBuilder: (context, index) {
                  return SizedBox(
                      width: MediaQuery.sizeOf(context).width * 1,
                      child: ServiceTile(
                        serviceID: '$index',
                        serviceTitle: 'Title $index',
                        serviceDesc: 'Description $index',
                        uploadedBy: '$index',
                        serviceImage: 'assets/portrait.jpg',
                        servicePrice: index * 1000 + 1000,
                        uploaderId: '$index',
                      ));
                },
              ),
            ),
          ]))
        ],
      ),
    );
  }
}
