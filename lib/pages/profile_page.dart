import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Notify/data/api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    Map<String, dynamic> userData =
        (await ApiService.getProfile()) as Map<String, dynamic>;
    setState(() {
      nameController.text = userData['fullName'] ?? '';
      emailController.text = userData['email'] ?? '';
      dobController.text = userData['dob'];
      phoneController.text = userData['phoneNo'] ?? '';
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.camera_alt),
                              title: Text('Take a Picture'),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.camera);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.photo_library),
                              title: Text('Choose from Gallery'),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.gallery);
                              },
                            )
                          ],
                        );
                      });
                },
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundColor: Colors.cyan,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? Icon(
                          Icons.camera_alt,
                          size: 50.0,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'DOB',
                    prefixIcon: Icon(Icons.calendar_month, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    )),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
