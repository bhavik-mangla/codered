import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:samplews/constants/drawer.dart';
import 'dart:convert';
import 'codered_classes.dart';

class MemesPage extends StatefulWidget {
  @override
  _MemesPageState createState() => _MemesPageState();
}

class _MemesPageState extends State<MemesPage> {
  List<Update> collegeUpdates = [];
  List<Meme> memes = [];

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse("https://mocki.io/v1/8eabdfe3-cd4b-48eb-af15-ae582be95be7"),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        memes =
            (data['memes'] as List).map((item) => Meme.fromJson(item)).toList();
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
        title: Text('Memes'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: memes.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(memes[index].title),
                SizedBox(height: 5),
                Image.network(memes[index].imageLink),
                SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}
