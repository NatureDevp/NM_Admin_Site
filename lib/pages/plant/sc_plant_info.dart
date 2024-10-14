import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ct_sidebar.dart';

class PlantInfo extends StatelessWidget {
  final String plantName;
  final String scientificName;
  final String description;
  final String imageUrl;

  const PlantInfo({
    super.key,
    this.plantName = 'Rosemary',
    this.scientificName = 'Salvia Rosmarinus',
    this.description =
        'Rosemary is a woody, perennial herb with fragrant, evergreen, needle-like leaves. It belongs to the mint family (Lamiaceae) and is native to the Mediterranean region. The plant can grow up to 1.5 meters in height and produces small, blue or white flowers. Rosemary has a distinct aromatic scent and is commonly used as a culinary herb for seasoning foods. In herbal medicine, it is valued for its potential antioxidant, anti-inflammatory, and cognitive-enhancing properties. Traditionally, rosemary has been used to aid digestion, boost memory, and improve circulation.',
    this.imageUrl = 'https://via.placeholder.com/200',
  });

  @override
  Widget build(BuildContext context) {
    SidebarController sidebarController = Get.put(SidebarController());

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top Navigation Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Icon(Icons.arrow_back, size: 30),
              ),
              const Text(
                'Plant Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Handle notifications here
                },
                icon: const Icon(Icons.notifications),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Plant Information Card
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Plant Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Plant Name
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Plant Name',
                      hintText: plantName,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 10),

                  // Scientific Name
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Scientific Name',
                      hintText: scientificName,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),

                  // Remedy Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle remedy functionality here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Remedy',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Plant Description
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
