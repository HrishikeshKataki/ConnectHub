import 'package:connecthub/pages/home/popular_services.dart';
import 'package:connecthub/pages/search_screen.dart';
import 'package:connecthub/pages/services/services.dart';
import 'package:connecthub/utils/layout.dart';
import 'package:connecthub/utils/my_colors.dart';
import 'package:connecthub/widgets/categories.dart';
import 'package:flutter/material.dart';
import 'package:connecthub/utils/txt.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(20),
              child: TextField(
                readOnly: true,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const Search())));
                },
                style: const TextStyle(color: secondaryText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: sbg,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  hintText: "Search the Marketplace",
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: primary,
                  suffixIcon: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      padding: const EdgeInsets.all(22),
                    ),
                    onPressed: () {},
                    child: const Icon(
                      Icons.search,
                      color: white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Category(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular Services',
                  style: txt.titleDark,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Services(
                                  srvCategory: 'Popular Services')));
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
            Featured(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Featured Deals',
                  style: txt.titleDark,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Services(
                                  srvCategory: 'Featured Deals')));
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
            FeaturedSection(
              sectionTitle: 'Featured Deals',
              services: [
                FeaturedHome(
                    srvTitle: 'AI designer',
                    srvImage: 'assets/beard.jpg',
                    srvDescription: 'Discount 20%'),
                FeaturedHome(
                    srvTitle: 'Game devloper',
                    srvImage: 'assets/aa.jpeg',
                    srvDescription: 'Discount 15%'),
                FeaturedHome(
                    srvTitle: 'Software Designer',
                    srvImage: 'assets/ss.jpg',
                    srvDescription: 'Discount 25%'),
                // Add more services here
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recommended for You',
                  style: txt.titleDark,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Services(
                                  srvCategory: 'Recommended for You')));
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
            FeaturedSection(
              sectionTitle: 'Recommended for You',
              services: [
                FeaturedHome(
                    srvTitle: 'AI designer',
                    srvImage: 'assets/vv.jpeg',
                    srvDescription: 'I am AI designer'),
                FeaturedHome(
                    srvTitle: 'Game Devloper',
                    srvImage: 'assets/ab.jpeg',
                    srvDescription: 'Devlop your game with affordable prices'),
                FeaturedHome(
                    srvTitle: 'Software designer',
                    srvImage: 'assets/aa.jpeg',
                    srvDescription: 'I am software devloper with 10 year exp.'),
                // Add more services here
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'News and Updates',
              style: txt.titleDark,
            ),
            const SizedBox(
              height: 10,
            ),
            NewsAndUpdatesSection(
              items: [
                NewsAndUpdateItem(
                  title: 'New App Update',
                  description: 'Version 2.0 is now available',
                  imageAsset: 'assets/a1.jpeg',
                  bgColor: Colors.blue.shade200,
                ),
                NewsAndUpdateItem(
                  title: 'New Services Added',
                  description: 'Check out our new services',
                  imageAsset: 'assets/a2.jpeg',
                  bgColor: Colors.green.shade200,
                ),
                NewsAndUpdateItem(
                  title: 'Special Offer for new customer',
                  description: 'Get 20% off on selected services',
                  imageAsset: 'assets/a3.jpeg',
                  bgColor: Colors.orange.shade200,
                ),
                // Add more news and updates here
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

class FeaturedHome {
  final String srvImage;
  final String srvTitle;
  final String srvDescription;

  FeaturedHome(
      {required this.srvTitle,
      required this.srvImage,
      required this.srvDescription});
}

class FeaturedSection extends StatelessWidget {
  final String sectionTitle;
  final List<FeaturedHome> services;

  const FeaturedSection({
    super.key,
    required this.sectionTitle,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        itemBuilder: (BuildContext context, int index) {
          final FeaturedHome service = services[index];
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>
                        Services(srvCategory: service.srvTitle)))),
            child: Card(
              surfaceTintColor: sbg,
              elevation: layout.elevation,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        service.srvImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            service.srvTitle,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          if (service.srvDescription.isNotEmpty)
                            Text(
                              service.srvDescription,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NewsAndUpdatesSection extends StatelessWidget {
  final List<NewsAndUpdateItem> items;

  const NewsAndUpdatesSection({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final NewsAndUpdateItem item = items[index];
          return NewsAndUpdateItemWidget(
            item: item,
          );
        },
      ),
    );
  }
}

class NewsAndUpdateItem {
  final String title;
  final String description;
  final String imageAsset;
  final Color bgColor;

  NewsAndUpdateItem({
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.bgColor,
  });
}

class NewsAndUpdateItemWidget extends StatelessWidget {
  final NewsAndUpdateItem item;

  const NewsAndUpdateItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: item.bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                item.imageAsset,
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
