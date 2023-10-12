import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:samplews/constants/drawer.dart';
import 'dart:convert';
import 'codered_classes.dart';
import 'attendance.dart';
import 'home.dart';

class UpdatesPage extends StatefulWidget {
  @override
  _UpdatesPageState createState() => _UpdatesPageState();
}

class _UpdatesPageState extends State<UpdatesPage> {
  List<Update> collegeUpdates = [];
  List<Meme> memes = [];

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse("https://mocki.io/v1/8eabdfe3-cd4b-48eb-af15-ae582be95be7"),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        collegeUpdates = (data['college_updates'] as List)
            .map((item) => Update.fromJson(item))
            .toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updates'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: collegeUpdates.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(collegeUpdates[index].title),
                  subtitle: Text(collegeUpdates[index].message),
                  trailing: Text(collegeUpdates[index].timestamp),
                );
              },
            ),
          ],
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}
