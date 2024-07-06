import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _serviceTitle,
      _serviceDescription,
      _servicePrice,
      _included1,
      _included2,
      _included3;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Service'),
          backgroundColor: const Color(0xFF4b39ef),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Service Title'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a service title';
                      }
                      return null;
                    },
                    onSaved: (value) => _serviceTitle = value,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Service Description'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a service description';
                      }
                      return null;
                    },
                    onSaved: (value) => _serviceDescription = value,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Service Price'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a service price';
                      }
                      return null;
                    },
                    onSaved: (value) => _servicePrice = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Included in Service 1'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter something included in the service';
                      }
                      return null;
                    },
                    onSaved: (value) => _included1 = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Included in Service 2'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter something included in the service';
                      }
                      return null;
                    },
                    onSaved: (value) => _included2 = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Included in Service 3'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter something included in the service';
                      }
                      return null;
                    },
                    onSaved: (value) => _included3 = value,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final userId = _auth.currentUser!.uid;
                          final serviceRef = _firestore
                              .collection('Service')
                              .doc(userId)
                              .collection('Yourservices');
                          final serviceData = {
                            'title': _serviceTitle,
                            'description': _serviceDescription,
                            'price': _servicePrice,
                            'included': [
                              _included1,
                              _included2,
                              _included3,
                            ],
                          };
                          await serviceRef.add(serviceData);
                          // Display success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Service added successfully!'),
                            ),
                          );
                          // Clear form fields
                          _serviceTitle = null;
                          _serviceDescription = null;
                          _servicePrice = null;
                          _included1 = null;
                          _included2 = null;
                          _included3 = null;
                          _formKey.currentState!.reset();
                        }
                      },
                      child: const Text('Add Service'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
