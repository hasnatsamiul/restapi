import 'package:flutter/material.dart';
//import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List users = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = false;
    });

    var url = "https://jsonplaceholder.typicode.com/posts";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        users = items;
        isLoading = false;
      });
    } else {
      users = [];
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Listing Json "),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          (users[index]);
        });
  }

  Widget getCard(item) {
    var fullname = item['title'];

    //var email = item['email'];
    //var profileUrl = item['picture']['large'];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    // borderRadius: BorderRadius.circular(60 / 2),
                    // image: DecorationImage(
                    // fit: BoxFit.cover,
                    // image: NetworkImage(profileUrl.toString())),
                  )),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    fullname.toString(),
                    style: TextStyle(fontSize: 17),
                  ),

                  SizedBox(height: 10),
                  //Text(
                  //email.toString(),
                  //style: TextStyle(color: Colors.grey),
                  //)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
