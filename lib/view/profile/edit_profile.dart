import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _checkAuthentication();
    _loadUserData();
  }
  
        Future<void> _checkAuthentication() async {
          User? user = FirebaseAuth.instance.currentUser;
          if (user == null) {
            Navigator.pushReplacementNamed(context, '/login');
          }
          }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            _nameController.text = userDoc['firstName'];
            _emailController.text = userDoc['email'];
            _passwordController.text = userDoc['password'];
          });
        }
      }
    } catch (e) {
      print('Failed to load user data: $e');
    }
  }

  Future<void> _saveChanges() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      DocumentReference userRef =
      FirebaseFirestore.instance.collection('users').doc(userId);
      DocumentSnapshot userDoc = await userRef.get();
      if (userDoc.exists) {
        await userRef.update({
        'firstName': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      });

      setState(() {
        _nameController.text = _nameController.text;
        _emailController.text = _emailController.text;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
    else {
      print('User document not found in Firestore');
    }
    }
     catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
    Navigator.pop(context);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Text(
              'Edit your profile:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter Name',
                hintText: 'Enter your name',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Enter Email',
                hintText: 'Enter your Email',
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Enter Password',
                hintText: 'Enter Email Password',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveChanges,
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
