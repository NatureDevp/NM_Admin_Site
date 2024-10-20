import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RemedyInfo extends StatefulWidget {
  const RemedyInfo({super.key});

  @override
  State<RemedyInfo> createState() => _RemedyInfoState();
}

class _RemedyInfoState extends State<RemedyInfo> {
  final TextEditingController _remedyNameController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _preparationController = TextEditingController();
  final TextEditingController _howToUseController = TextEditingController();
  final TextEditingController _videoController = TextEditingController();
  XFile? _remedyImage;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>(); // Key for the form

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _remedyImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remedy Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              width: 800,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Form(
                key: _formKey, // Wrap everything inside the Form widget
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Remedy Name and Remedy Picture (side by side)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Remedy Name
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Remedy name:'),
                                const SizedBox(height: 8.0),
                                TextFormField(
                                  controller: _remedyNameController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter remedy name',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Remedy Picture
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Remedy Picture'),
                              const SizedBox(height: 8.0),
                              _remedyImage == null
                                  ? Container(
                                      height: 120,
                                      width: 120,
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.image, size: 50),
                                    )
                                  : Image.file(
                                      File(_remedyImage!.path),
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                              const SizedBox(height: 8.0),
                              ElevatedButton(
                                onPressed: _pickImage,
                                child: const Text('Upload'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),

                    // Ingredients
                    const Text('Ingredients:'),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _ingredientsController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter ingredients',
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // Preparation Steps
                    const Text('Preparation Steps:'),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _preparationController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter preparation steps',
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // How to Use
                    const Text('How to Use:'),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _howToUseController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter how to use',
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // Video Tutorial
                    const Text('Video Tutorial:'),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _videoController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter video tutorial link',
                      ),
                    ),
                    const SizedBox(height: 32.0),

                    // Buttons (Cancel and Save)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 17, 0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 12.0),
                          ),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Handle save logic here
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 0, 255, 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 12.0),
                          ),
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
