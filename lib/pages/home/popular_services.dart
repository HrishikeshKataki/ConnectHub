import 'package:connecthub/pages/services/services.dart';
import 'package:connecthub/utils/layout.dart';
import 'package:connecthub/utils/my_colors.dart';
import 'package:flutter/material.dart';

class FeaturedHome {
  final String srvImage;
  final String srvTitle;

  FeaturedHome({required this.srvTitle, required this.srvImage});
}

class Featured extends StatelessWidget {
  Featured({super.key});
  final List<FeaturedHome> pservice = [
    FeaturedHome(srvTitle: 'App Development ', srvImage: 'assets/handshake.jpg'),
    FeaturedHome(
        srvTitle: 'Website Development', srvImage: 'assets/typewriter.jpg'),
    FeaturedHome(
        srvTitle: 'AI Art', srvImage: 'assets/beard.jpg'),
    FeaturedHome(srvTitle: 'Game Development', srvImage: 'assets/yellow.jpg'),
    FeaturedHome(
        srvTitle: 'Influencer Marketing', srvImage: 'assets/portrait.jpg'),
    FeaturedHome(srvTitle: 'Merchandise Design', srvImage: 'assets/yellow.jpg')
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pservice.length,
        itemBuilder: (BuildContext context, int index) {
          final FeaturedHome pS = pservice[index];
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>
                        Services(srvCategory: pS.srvTitle)))),
            child: Card(
              surfaceTintColor: sbg,
              elevation: layout.elevation,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.45,
                child: Column(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Image.asset(
                          pS.srvImage,
                        )),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          pS.srvTitle,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
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
