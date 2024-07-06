import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connecthub/pages/profile_edit/profiledb.dart';
import 'package:connecthub/pages/search_screen.dart';
import 'package:connecthub/pages/services/add_service.dart';
import 'package:connecthub/utils/my_colors.dart';
import 'package:connecthub/widgets/like_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'freelancer/editfreelancer_Data.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FPService {
  final String title;
  final String description;
  final String price;
  final List<String> included;
  String userId;

  FPService({
    required this.title,
    required this.description,
    required this.price,
    required this.included,
    this.userId = '',
  });

  factory FPService.fromFirestore(Map<String, dynamic> data) {
    return FPService(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? '',
      included: List<String>.from(data['included'] ?? []),
    );
  }
}

//todo: info1,2,3 and all attributes of a class cannot be null because of Dart's Null Safety and probably will result in error even if i remove null safety.So i'll have to dynamically add more attributes when needed so that they always contain a values and those who don't are not included in the class. So when a user wants to add more info points to their service listing they can click a button and that buttons onPressed action will add another info attribute to the individual service. But then again they will have to put that additional info on all their services or the same problem will arise.Gotta figure something out.
//?: Maybe limit the number of info points to 3? Because the pageView builder also needs a fixed height

class FreelancerProfile extends StatefulWidget {
  final String freelancerId;
  final bool account;
  const FreelancerProfile(
      {super.key, required this.freelancerId, required this.account});

  @override
  _FreelancerProfileWidgetState createState() =>
      _FreelancerProfileWidgetState();
}

class _FreelancerProfileWidgetState extends State<FreelancerProfile> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<FPService> services = [];
  bool isLoading = true;

  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();
  String? name,
      profession,
      language,
      about,
      contact,
      experience,
      projects,
      email,
      _downloadURL;
  @override
  void initState() {
    super.initState();
    final User? user = _authService.getCurrentUser();
    if (user != null) {
      final String freelancerId = user.uid;

      fetchServices(freelancerId);
    }
    _fetchFreelancerData();
  }

  Future<void> _fetchFreelancerData() async {
    final User? user = _authService.getCurrentUser();
    if (user != null) {
      final userData = await _databaseService.getUserData(user.uid);
      setState(() {
        name = userData['name'] ?? '';
        profession = userData['profession'] ?? '';
        language = userData['language'] ?? '';
        about = userData['about'] ?? '';
        contact = userData['contact'] ?? '';
        experience = userData['experience'] ?? '';
        projects = userData['projects'] ?? '';
        email = userData['email'] ?? '';
        _downloadURL = userData['image_url'];
      });
    }
  }

  Future<void> fetchServices(String freelancerId) async {
    try {
      final querySnapshot = await _firestore
          .collection('Service')
          .doc(freelancerId)
          .collection('Yourservices')
          .get();
      final serviceList = querySnapshot.docs.map((doc) {
        return FPService.fromFirestore(doc.data());
      }).toList();

      setState(() {
        services = serviceList;
        isLoading = false;
      });
      for (var service in services) {
        print(
            'Fetched Service: ${service.title}, ${service.description}, ${service.price}, ${service.included}');
      }
    } catch (e) {
      print("No Services $e");
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      // Upload the new image to Firestore
      final storageRef = FirebaseStorage.instance.ref();
      final uploadTask = storageRef
          .child('profile_images/${widget.freelancerId}')
          .putFile(file);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadURL = await snapshot.ref.getDownloadURL();
      // Update the image URL in Firestore
      await _databaseService
          .updateUserData(widget.freelancerId, {'image_url': downloadURL});
      setState(() {
        _downloadURL = downloadURL;
      });
    }
  }

  Future<void> _showImageSourceActionSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: bg,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddServiceScreen()));
        },
        tooltip: 'ADD YOUR SERVICES HERE',
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: primary,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                      child: SafeArea(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (!widget.account)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 0, 0),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.keyboard_backspace_rounded,
                                      color: white,
                                      size: 28,
                                    )),
                              ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (widget.account)
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const EditFreelancerData()));
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: white,
                                            size: 28,
                                          )),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Search()));
                                        },
                                        icon: const Icon(
                                          Icons.search,
                                          color: white,
                                          size: 28,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                      child: Text(profession ?? '',
                          textAlign: TextAlign.justify,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: white)),
                    ),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: _downloadURL != null
                              ? NetworkImage(_downloadURL ?? '')
                              : null,
                          child: _downloadURL == null
                              ? const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.add_a_photo,
                              color: Color.fromARGB(255, 22, 23, 24),
                              size: 20,
                            ),
                            onPressed: () {
                              _showImageSourceActionSheet();
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(name ?? '',
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: white)),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: RatingBarIndicator(
                            itemBuilder: (context, index) => const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                            direction: Axis.horizontal,
                            rating: 4,
                            unratedColor: Colors.grey[400],
                            itemCount: 5,
                            itemPadding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            itemSize: 22,
                          ),
                        ),
                        Text(
                          experience ?? '',
                          style: const TextStyle(
                            color: Color(0xFFf1f4f8),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 5),
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Contact Me'),
                                content: SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.13,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                                text: email ?? ''));
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
                                        OutlinedButton(
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                                text: contact ?? ''));
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
                              foregroundColor: primary,
                              backgroundColor: sbg),
                          child: const Text(
                            'Contact Me',
                            style: TextStyle(
                              color: Color(0xFF4b39ef),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                    child: Text(
                      'About Me -',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                    child: Text(about ?? '',
                        textAlign: TextAlign.start,
                        maxLines: 4,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: secondaryText)),
                  ),
                ),
                Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Projects: $projects',
                          style: const TextStyle(
                            color: secondaryText,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          'Language: $language',
                          style: const TextStyle(
                            color: secondaryText,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 300,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final FPService service = services[index];
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: sbg,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 14, 10, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    service.title,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                Text(
                                  "₹${service.price}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryText,
                                  ),
                                ),
                              ],
                            )),
                        const Divider(
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                          child: Text(
                            service.description,
                            style: const TextStyle(
                              fontSize: 18,
                              color: secondaryText,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                List.generate(service.included.length, (index) {
                              return Row(
                                children: [
                                  const Icon(Icons.check_circle,
                                      color: Colors.green),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      service.included[index],
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
