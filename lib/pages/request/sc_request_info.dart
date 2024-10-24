import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ct_request.dart';

class RequestInfoPage extends GetView<RequestController> {
  const RequestInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    var request = controller.selectedRequest();
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text('Request Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextField('ID:', request.id.toString()),
                            _buildTextField(
                                'User_ID:', request.user_id.toString()),
                            _buildTextField('Plant Name:', request.plant_name),
                            _buildTextField(
                                'Scientific Name:', request.scientific_name),
                            _buildMultiLineTextField(
                                'Plant Description:', request.description),
                            _buildTextField(
                              'Handle by:',
                              request.handle_by != null
                                  ? request.handle_by.toString()
                                  : 'None',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildImageSection(
                              'Plant Image:',
                              // 'assets/${controller.selectedRequest.value!.image_url}',
                              'assets/images/image1.png',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                            'Last Update:', request.last_updated),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildTextField(
                          'Date Created:',
                          request.date_created,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          TextFormField(
            initialValue: value,
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiLineTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          TextFormField(
            initialValue: value,
            maxLines: 4,
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(String label, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: imageUrl.isNotEmpty
                ? Image.asset(imageUrl, fit: BoxFit.cover)
                : const Icon(Icons.image, size: 80, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
