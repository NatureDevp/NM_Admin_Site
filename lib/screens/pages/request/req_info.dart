import 'package:admin_side/controllers/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/navigation.dart';

class RequestInformation extends StatelessWidget {
  const RequestInformation({super.key});

  @override
  Widget build(BuildContext context) {
    SidebarController sidebarController = Get.put(SidebarController());

    // Sample data to simulate request information. Replace with real data source.
    const String plantName = 'Aloe Vera';
    const String plantScientificName = 'Aloe barbadensis miller';
    const String requesterName = 'John Doe';
    const String requesterEmail = 'johndoe@gmail.com';
    const String requestTimestamp = 'June 23, 2024\n12:00 PM';
    String requestStatus = 'Pending';
    const String requestDescription =
        'I request the inclusion of Aloe Vera (Aloe barbadensis miller) as a medicinal plant. It is widely used for its anti-inflammatory, antimicrobial, and skin-soothing properties, making it effective for treating burns, cuts, and other skin conditions.';

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top navigation bar with back button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopNavigation(
                    back: () {
                      sidebarController.selectButton(1);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {
                      _showAdditionalInfoDialog(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Plant name, image, and request information
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Plant image
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/plantImages/plant1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Request information card
                  Expanded(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              plantName,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              plantScientificName,
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const Divider(height: 20, thickness: 1),
                            const Text(
                              'Request Information:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _requestInfoRow(
                              'Request by',
                              requesterName,
                              email: requesterEmail,
                            ),
                            _requestInfoRow(
                                'Request Timestamp', requestTimestamp),
                            _requestInfoRow(
                              'Request Status',
                              requestStatus,
                              isStatus: true,
                              statusColor: _getStatusColor(requestStatus),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Request description section
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        requestDescription,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Accept, Reject, and Resubmit buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (requestStatus == 'Rejected') ...[
                    ElevatedButton(
                      onPressed: () {
                        // Handle resubmit action
                        requestStatus = 'Pending';
                        sidebarController.update();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Resubmit',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                  if (requestStatus == 'Pending') ...[
                    ElevatedButton(
                      onPressed: () {
                        // Handle reject action
                        requestStatus = 'Rejected';
                        sidebarController.update();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Reject',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle accept action
                        requestStatus = 'Accepted';
                        sidebarController.update();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Accept',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _requestInfoRow(String label, String value,
      {String? email, bool isStatus = false, Color? statusColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          if (isStatus)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor ?? Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else if (email != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value),
                GestureDetector(
                  onTap: () {
                    //TODO: Add email handling logic here
                  },
                  child: Text(
                    email,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            )
          else
            Text(value),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      case 'Accepted':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // Modal dialog function
  void _showAdditionalInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Additional Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //_buildRichText: A helper function (_buildRichText) was created to avoid repetitive code. It takes a label and value as arguments,
              _buildRichText('User ID: ', '#120'),
              _buildRichText('Request by: ', 'John Doe'),
              _buildRichText('User Email: ', 'johndoe@gmail.com'),
              _buildRichText('Request Timestamp: ', 'June 23, 2024, 12:00 PM'),
              _buildRichText('Request Status: ', 'Pending'),
              const SizedBox(height: 15),
              _buildRichText('Admin ID: ', 'N/A'),
              _buildRichText('Assigned Admin: ', 'N/A'),
              _buildRichText('Last Modified: ', 'N/A'),
              _buildRichText('Admin Remarks: ', 'N/A'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRichText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: label,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
