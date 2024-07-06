import 'package:connecthub/auth/freelancer/authentication.dart';
import 'package:connecthub/pages/profile_edit/freelancer/edit_db.dart';
import 'package:connecthub/pages/profile_edit/freelancer_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connecthub/utils/my_colors.dart';
import 'package:connecthub/utils/txt.dart';
import 'package:connecthub/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditFreelancerData extends StatefulWidget {
  const EditFreelancerData({Key? key}) : super(key: key);

  @override
  _FreelancerFormState createState() => _FreelancerFormState();
}

class _FreelancerFormState extends State<EditFreelancerData> {
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
  List<TextEditingController> _serviceControllers = [];
  final _serviceEntryController = TextEditingController();
  bool _isSubmitting = false;

  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _serviceEntryController.addListener(() {
      if (_serviceEntryController.text.contains('\n')) {
        setState(() {
          _serviceControllers.add(TextEditingController(text: _serviceEntryController.text.trim()));
          _serviceEntryController.clear();
        });
      }
    });
    _experienceController.addListener(() {
      final text = _experienceController.text.trim();
      if (text.isNotEmpty && !text.endsWith(' years')) {
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

  Future<void> _fetchUserData() async {
    final User? user = _authService.getCurrentUser();
    if (user != null) {
      final userData = await _databaseService.getUserData(user.uid);
      setState(() {
        _nameController.text = userData['name'] ?? '';
        _ageController.text = userData['age'] ?? '';
        _nationalityController.text = userData['nationality'] ?? '';
        _skillsController.text = userData['skills'] ?? '';
        _professionController.text = userData['profession'] ?? '';
        _aboutController.text = userData['about'] ?? '';
        _contactController.text = userData['contact'] ?? '';
        _languageController.text = userData['language'] ?? '';
        _experienceController.text = userData['experience'] ?? '';
        _projectsController.text = userData['projects'] ?? '';
        _serviceControllers = (userData['services'] as List<dynamic>?)
                ?.map((service) => TextEditingController(text: service.toString()))
                .toList() ?? [];
      });
    }
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
                        validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
                      ),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Age',
                        controller: _ageController,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (value) => value == null || value.isEmpty ? 'Please enter your age' : null,
                      ),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Nationality',
                        controller: _nationalityController,
                        validator: (value) => value == null || value.isEmpty ? 'Please enter your nationality' : null,
                      ),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Skills',
                        controller: _skillsController,
                        validator: (value) => value == null || value.isEmpty ? 'Please enter your skills' : null,
                      ),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Profession',
                        controller: _professionController,
                        validator: (value) => value == null || value.isEmpty ? 'Please enter your profession' : null,
                      ),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'About',
                        controller: _aboutController,
                        validator: (value) => value == null || value.isEmpty ? 'Please enter about yourself' : null,
                      ),
                      _buildServiceEntryField(),
                      ..._buildServiceFields(),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Contact details',
                        controller: _contactController,
                        validator: (value) => value == null || value.isEmpty ? 'Please enter your contact details' : null,
                      ),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Language',
                        controller: _languageController,
                        validator: (value) => value == null || value.isEmpty ? 'Please enter languages you know' : null,
                      ),
                      _buildExperienceField(),
                      _buildTextFieldWithLabelAndValidator(
                        label: 'Projects Done (Optional)',
                        controller: _projectsController,
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
        decoration: InputDecoration(
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
        await _databaseService.updateUserData(user.uid, _getUserData());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account Successfully Updated')),
        );

        await Future.delayed(const Duration(seconds: 3));

        Navigator.push(context, MaterialPageRoute
                              (builder: (context) => 
                              FreelancerProfile(freelancerId: user.uid, // Use user UID as freelancer ID
                              account: true, // Provide the account status
                            ),
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
      'services': _serviceControllers.map((controller) => controller.text).toList(),
      'contact': _contactController.text,
      'language': _languageController.text,
      'experience': _experienceController.text.isNotEmpty ? _experienceController.text : null,
      'projects': _projectsController.text.isNotEmpty ? _projectsController.text : null,
    };
  }
}
