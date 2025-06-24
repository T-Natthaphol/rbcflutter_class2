import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rbcknightflutter/pages/authentication_page.dart';
// import 'package:rbcfluttermark1/states/usersigninpage.dart';

class UserSignupPage extends StatefulWidget {
  const UserSignupPage({super.key});

  @override
  State<UserSignupPage> createState() => _UserSignupPageState();
}

class _UserSignupPageState extends State<UserSignupPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  File? _profileImage;
  bool _isLoading = false;

  // Future<void> _pickImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _profileImage = File(pickedFile.path);
  //     });
  //   }
  // }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _showImagePickerMenu() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('เลือกรูปจาก Gallery'),
                onTap: () {
                  Navigator.pop(context); // ปิดเมนู
                  _pickImage(ImageSource.gallery); // เลือกรูปจาก Gallery
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('ถ่ายรูปจาก Camera'),
                onTap: () {
                  Navigator.pop(context); // ปิดเมนู
                  _pickImage(ImageSource.camera); // ถ่ายรูปจาก Camera
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // สร้างผู้ใช้ด้วยอีเมลและรหัสผ่าน
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password:
              _passwordController.text, // ตั้งรหัสผ่านเริ่มต้นหรือให้ผู้ใช้กรอก
        );

        // อัปโหลดรูปภาพโปรไฟล์ (ถ้ามี)
        String profileImageUrl = '';
        if (_profileImage != null) {
          Reference storageReference = _storage
              .ref()
              .child('profile_images/${userCredential.user!.uid}');
          UploadTask uploadTask = storageReference.putFile(_profileImage!);
          TaskSnapshot taskSnapshot = await uploadTask;
          profileImageUrl = await taskSnapshot.ref.getDownloadURL();
        }

        // บันทึกข้อมูลผู้ใช้ใน Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': _emailController.text.trim(),
          'fullName': _fullNameController.text.trim(),
          'phoneNumber': _phoneNumberController.text.trim(),
          'username': _usernameController.text.trim(),
          'profileImage': profileImageUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up successful!')),
        );

        // เคลียร์ฟอร์มหลังจากสมัครสมาชิกเสร็จสิ้น
        _formKey.currentState!.reset();
        setState(() {
          _profileImage = null;
          _isLoading = false;
        });

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AuthenPage()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AuthenPage()));
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        _profileImage == null
            ? const Icon(Icons.account_circle, size: 100)
            : CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(_profileImage!),
              ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _showImagePickerMenu,
          child: const Text('Pick Profile Image'),
        ),
      ],
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool isPassword) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      obscureText: isPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildSignInText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Ready have an account?"),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const AuthenPage()));
          },
          child: const Text('Sign In'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildImagePicker(),
              const SizedBox(height: 20),
              _buildTextField('Email', _emailController, false),
              _buildTextField('Full Name', _fullNameController, false),
              _buildTextField('Phone Number', _phoneNumberController, false),
              _buildTextField('Username', _usernameController, false),
              _buildTextField('Password', _passwordController, true),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _signUp,
                      child: const Text('Sign Up'),
                    ),
              _buildSignInText(),
            ],
          ),
        ),
      ),
    );
  }
}
