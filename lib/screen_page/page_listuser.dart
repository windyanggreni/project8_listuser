import 'package:flutter/material.dart';
import 'package:project8_listuser/screen_page/page_detailuser.dart';
import '../model/model_user.dart';
import 'user_service.dart';

class PageListUser extends StatefulWidget {
  @override
  _PageListUserState createState() => _PageListUserState();
}

class _PageListUserState extends State<PageListUser> {
  final UserService userService = UserService();
  List<User> _users = [];
  List<User> _filteredUsers = [];
  bool _isLoading = true;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      final users = await userService.fetchUsers();
      setState(() {
        _users = users;
        _filteredUsers = users;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load users')),
      );
    }
  }

  void _filterUsers(String query) {
    setState(() {
      _searchText = query;
      if (query.isEmpty) {
        _filteredUsers = _users;
      } else {
        _filteredUsers = _users
            .where((user) =>
        user.firstName.toLowerCase().contains(query.toLowerCase()) ||
            user.lastName.toLowerCase().contains(query.toLowerCase()) ||
            user.email.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List User'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterUsers,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _filteredUsers.isEmpty
                ? Center(child: Text('Data User Tidak Ditemukan'))
                : ListView.builder(
              itemCount: _filteredUsers.length,
              itemBuilder: (context, index) {
                final user = _filteredUsers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(user.email),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PageDetailUser(user: user),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
