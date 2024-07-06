import 'package:connecthub/pages/services/service_details.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:connecthub/utils/my_colors.dart';
import 'package:flutter/widgets.dart';

class FieldModel {
  String? service_title;
  String? freelancer_name;
  FieldModel(this.service_title, this.freelancer_name);
}

class Search extends StatefulWidget {
  static const routename = "search";

  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
// sample lists for filtering

  static List<FieldModel> main_field_list = [
    FieldModel("Web Development", "John Doe"),
    FieldModel("React Developer", "Jane Smith"),
    FieldModel("Flutter Developer", "Bob Johnson"),
    FieldModel("Project Management", "Alice Williams"),
    FieldModel("Back End Developer", "Charlie Brown"),
    FieldModel("Graphic Design", "David Lee"),
    FieldModel("Content Writing", "Emily Wong"),
    FieldModel("Social Media Management", "Frank Chen"),
    FieldModel("SEO Specialist", "Grace Kim"),
    FieldModel("Data Analysis", "Hannah Park"),
    FieldModel("Mobile App Development", "Irene Lee"),
    FieldModel("Mobile App Development", "Jack Wang"),
    FieldModel("Mobile App Development", "Jill Yang"),
    FieldModel("Mobile App Development", "Kevin Lee"),
    FieldModel("Mobile App Development", "Lily Park"),
    FieldModel("Mobile App Development", "Michael Kim"),
    FieldModel("Mobile App Development", "Olivia Lee"),
    FieldModel("Mobile App Development", "Patrick Wang"),
    FieldModel("Mobile App Development", "Qiang Chen"),
    FieldModel("Mobile App Development", "Rachel Kim"),
    FieldModel("Cloud Computing", "David Lee"),
    FieldModel("Cybersecurity", "Emily Wong"),
    FieldModel("DevOps Engineering", "Frank Chen"),
    FieldModel("Quality Assurance", "Grace Kim"),
    FieldModel("Technical Writing", "Hannah Park"),
    FieldModel("Product Management", "Irene Lee"),
    FieldModel("User Experience Design", "Jack Wang"),
    FieldModel("Customer Support", "Jill Yang"),
    FieldModel("Marketing Strategy", "Kevin Lee"),
  ];
  List<FieldModel> display_list = List.from(main_field_list);
  void Updatelist(String value) {
// for filtering the list
    setState(() {
      display_list = main_field_list
          .where((element) => element.service_title!
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40, left: 12),
            child: Row(
              children: [
                Text("Search for a Service",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primary)),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextField(
              onChanged: (value) => Updatelist(value),
              style: const TextStyle(color: secondaryText),
              decoration: InputDecoration(
                filled: true,
                fillColor: sbg,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                hintText: "Mobile Development",
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
            height: 10.0,
          ),
          Expanded(
            child: display_list.isEmpty
                ? const Center(
                    child: Text("No result found",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )))
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: display_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceDetails(
                                title: display_list[index].service_title!,
                                desc:
                                    "Service description", // Add a description here
                                image:
                                    "assets/beard.jpg", // Add an image URL here
                                uploadedBy:
                                    display_list[index].freelancer_name!,
                                uploaderId:
                                    "uploader_id", // Add an uploader ID here
                                price: 5000, // Add a price here
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(display_list[index].service_title!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Text(display_list[index].freelancer_name!,
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    ));
  }
}
