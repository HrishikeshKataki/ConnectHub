import 'dart:io';
import 'package:connecthub/auth/freelancer/authentication.dart';
import 'package:connecthub/auth/freelancer/db.dart';
import 'package:connecthub/pages/signing%20in_up/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connecthub/utils/my_colors.dart';
import 'package:connecthub/utils/txt.dart';
import 'package:connecthub/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FreelancerForm extends StatefulWidget {
  const FreelancerForm({super.key});

  @override
  _FreelancerFormState createState() => _FreelancerFormState();
}

class _FreelancerFormState extends State<FreelancerForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _skillsController = TextEditingController();
  final _professionController = TextEditingController();
  final _aboutController = TextEditingController();
  final _contactController = TextEditingController();
  final _languageController = TextEditingController();
  final _experienceController = TextEditingController();
  final _projectsController = TextEditingController();
  final List<TextEditingController> _serviceControllers = [];
  final _serviceEntryController = TextEditingController();
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();
  File? _image;
  String? _downloadURL;
  bool _isSubmitting = false;
  @override
  void initState() {
    super.initState();
    _serviceEntryController.addListener(() {
      if (_serviceEntryController.text.contains('\n')) {
        setState(() {
          _serviceControllers.add(
              TextEditingController(text: _serviceEntryController.text.trim()));
          _serviceEntryController.clear();
        });
      }
    });
    _experienceController.addListener(() {
      final text = _experienceController.text.trim();
      if (text.isNotEmpty && !text.endsWith('years')) {
        setState(() {
          _experienceController.value = TextEditingValue(
            text: '$text years',
            selection: TextSelection.fromPosition(
              TextPosition(offset: ('$text years').length),
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _nationalityController.dispose();
    _skillsController.dispose();
    _professionController.dispose();
    _aboutController.dispose();
    _contactController.dispose();
    _languageController.dispose();
    _experienceController.dispose();
    _projectsController.dispose();
    _serviceEntryController.dispose();
    for (var controller in _serviceControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tell us about Yourself'),
        titleTextStyle: txt.appBarTitle,
        iconTheme: const IconThemeData(color: white),
        backgroundColor: primary,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Name',
                        controller: _nameController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your name'
                            : null,
                      ),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Age',
                        controller: _ageController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your age'
                            : null,
                      ),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Nationality',
                        controller: _nationalityController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your nationality'
                            : null,
                      ),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Skills',
                        controller: _skillsController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your skills'
                            : null,
                      ),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Profession',
                        controller: _professionController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your profession'
                            : null,
                      ),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'About',
                        controller: _aboutController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter about yourself'
                            : null,
                      ),
                      _buildServiceEntryField(),
                      ..._buildServiceFields(),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Contact details',
                        controller: _contactController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your contact details'
                            : null,
                      ),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Language',
                        controller: _languageController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter languages you know'
                            : null,
                      ),
                      _buildExperienceField(),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Projects Done (Optional)',
                        controller: _projectsController,
                      ),
                      const SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: _showImageSourceActionSheet,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _downloadURL != null
                                ? Image.network(
                                    _downloadURL!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey.withOpacity(0.3),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                            const SizedBox(height: 5.0),
                            const Text(
                              'Tap here to add image',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      CustomButton(
                        buttonText: 'Submit',
                        onPressed: _isSubmitting ? null : _submitForm,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_isSubmitting)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithLabelAndValidator({
    required String label,
    required TextEditingController controller,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
        validator: validator,
        inputFormatters: inputFormatters,
      ),
    );
  }

  Widget _buildServiceEntryField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: _serviceEntryController,
        decoration: const InputDecoration(
          labelText: 'Services you want to provide',
        ),
        textInputAction: TextInputAction.newline,
        maxLines: null,
      ),
    );
  }

  List<Widget> _buildServiceFields() {
    return _serviceControllers.map((controller) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(controller.text),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _serviceControllers.remove(controller);
                  });
                },
                child: const Icon(Icons.close, size: 16, color: Colors.red),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildExperienceField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: _experienceController,
        decoration: const InputDecoration(
          labelText: 'Years of Experience (Optional)',
        ),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))],
        keyboardType: TextInputType.number,
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      _formKey.currentState!.save();

      final User? user = _authService.getCurrentUser();

      if (user != null) {
        _getUserData();

        if (_image != null) {
          final userId = user.uid;
          final downloadUrl =
              await _databaseService.uploadImageToFirestore(_image!, userId);

          if (downloadUrl != null) {
            await _databaseService.updateUserProfilePictureUrl(
                userId, downloadUrl);
          }
        }

        await _databaseService.saveFormDataToFirestore(
            user.uid, _getUserData(), _image);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account Successfully Created')),
        );

        await Future.delayed(const Duration(seconds: 2));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(userData: _getUserData()),
          ),
        );
      }

      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Map<String, dynamic> _getUserData() {
    return {
      'name': _nameController.text,
      'age': _ageController.text,
      'nationality': _nationalityController.text,
      'skills': _skillsController.text,
      'profession': _professionController.text,
      'about': _aboutController.text,
      'services':
          _serviceControllers.map((controller) => controller.text).toList(),
      'contact': _contactController.text,
      'language': _languageController.text,
      'experience': _experienceController.text.isNotEmpty
          ? _experienceController.text
          : null,
      'projects':
          _projectsController.text.isNotEmpty ? _projectsController.text : null,
      'image_URL': _downloadURL,
    };
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

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _uploadImage();
      });
    }
  }

  Future<void> _uploadImage() async {
    final file = _image!;
    final userId = _authService.getCurrentUser()?.uid;
    final downloadUrl =
        await _databaseService.uploadImageToFirestore(file, userId!);
    if (downloadUrl != null) {
      // Update the user's profile picture URL in the database
      await _databaseService.updateUserProfilePictureUrl(userId, downloadUrl);
      setState(() {
        _downloadURL = downloadUrl;
      });
    }
  }
}
