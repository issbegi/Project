import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key); // Corrected constructor

  @override
  State<HelpPage> createState() => _HelpPageState();
}


class _HelpPageState extends State<HelpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController =TextEditingController();
  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: SingleChildScrollView(
        padding:const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const Text(
              'Ask Question',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: TextFormField(
              controller: _questionController,
              validator: RequiredValidator(errorText: 'Please enter your question').call,
              decoration: const InputDecoration(
                hintText: 'Type your question here...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()){
                _questionController.clear();
                }
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height:20),
              const Text(
                'Frequently Asked Questions:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 4,
                shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const ListTile(
                title: Text('-> Does the store have any Social Platforms?'),
                subtitle: Text(' Yes. You can reach out to us through Instagram.@UrbanFootprint, Twitter.@UrbanFootprint and Facebook.@UrbanFootprint '),
                tileColor: Color.fromARGB(255, 183, 221, 240),
              ),
              ),
              const SizedBox(height: 10),
               Card(
                elevation: 4,
                shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            child:  const ListTile(
                title: Text('-> How do I contact support?'),
                subtitle: Text('You can get support by emailing urbanfootprint@hotmail.com or simply calling 0721786576.'),
                tileColor: Color.fromARGB(255, 183, 221, 240),
            ),  
              ),
            ],
          ),
        ),
    );
  }
}