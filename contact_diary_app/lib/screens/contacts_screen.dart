import 'package:contact_diary_app/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Diary',
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: contacts.isEmpty
          ? const Center(
              child: Text(
                "No contacts yet. Tap + to add one!",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return contactCard(contacts[index], index);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddContactDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddContactDialog() {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final nameRegex = RegExp(r'^[a-zA-Z ]+$');
    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$'); // basic email regex

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Add New Contact'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    } else if (!nameRegex.hasMatch(value)) {
                      return 'Invalid name format';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: mobileController,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mobile number is required';
                    } else if (value.length != 10) {
                      return 'Mobile number should be 10 digits long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!emailRegex.hasMatch(value)) {
                      return 'Invalid email format';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final String name = nameController.text;
                  final String mobileNumber = mobileController.text;
                  final String email = emailController.text;

                  final newContact = Contact(
                    name: name,
                    mobileNumber: mobileNumber,
                    email: email,
                  );

                  setState(() {
                    contacts.add(newContact);
                  });

                  nameController.clear();
                  mobileController.clear();
                  emailController.clear();

                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Contact added successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Card contactCard(Contact contact, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          contact.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contact.mobileNumber,
                style: const TextStyle(color: Colors.grey)),
            Text(contact.email, style: const TextStyle(color: Colors.grey)),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            setState(() {
              contacts.removeAt(index);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Contact deleted"),
                backgroundColor: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
