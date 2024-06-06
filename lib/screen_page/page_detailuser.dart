import 'package:flutter/material.dart';
import '../model/model_user.dart';

class PageDetailUser extends StatelessWidget {
  final User user;

  PageDetailUser({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.avatar),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                '${user.firstName} ${user.lastName}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 8),
            buildDetailRow(Icons.person, 'First Name', user.firstName),
            buildDetailRow(Icons.person_outline, 'Last Name', user.lastName),
            buildDetailRow(Icons.email, 'Email', user.email),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 16),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
