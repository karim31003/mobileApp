import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, //  AppBar
        title: const Text('Contact Us'),
      ),
      body: GestureDetector(
        
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ContactForm(),
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form submitted successfully!')),
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      fillColor:  Color.fromARGB(26, 255, 255, 255),
      filled: true,
      labelStyle: TextStyle(color:  Colors.blueAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      
      key: _formKey,
      
      child: ListView(
        children: [
          const SizedBox(height: 50.0),
          TextFormField(
            controller: _nameController,
            decoration: _inputDecoration('Name'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 25.0),
          TextFormField(
            controller: _emailController,
            decoration: _inputDecoration('Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 32.0),
          TextFormField(
            controller: _messageController,
            decoration: _inputDecoration('Please write your complaint in details'),
            maxLines: 5,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Message is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
               backgroundColor: Colors.blue, // 
              foregroundColor: Colors.white,
            ),
            onPressed: _submitForm,
            child: const Text('Submit',style: TextStyle(fontSize: 18,),),
          ),
        ],
      ),
    );
  }
}