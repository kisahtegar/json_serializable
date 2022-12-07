import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './model/model2/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<UserModel?> getDataUser() async {
    // Parsing url json
    Uri url = Uri.parse('https://reqres.in/api/users/2');
    var response = await http.get(url);

    // Testing debugging
    debugPrint(
        '[dbg]getDataUser: Status code = ${response.statusCode.toString()}');
    if (response.statusCode != 200) {
      debugPrint('[dbg]getDataUser: Something error code 404');
      return null;
    } else {
      debugPrint('[dbg]getDataUser: ${response.body}');
      Map<String, dynamic> data =
          (json.decode(response.body) as Map<String, dynamic>);
      return UserModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing Json Serializable'),
        //[start] This for debugging
        leading: InkWell(
          onTap: () {
            getDataUser();
          },
          child: const Icon(Icons.settings),
        ),
      ),
      //[end]

      body: FutureBuilder<UserModel?>(
        future: getDataUser(),
        builder: (context, snapshot) {
          // [start] if else logic if something happend
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(snapshot.data!.data.avatar),
                    ),
                    Text('Id : ${snapshot.data!.data.id}'),
                    Text('Email : ${snapshot.data!.data.email}'),
                    Text(
                        'Name : ${snapshot.data!.data.first_name} ${snapshot.data!.data.last_name}'),
                    const SizedBox(height: 10),
                    Text('Url : ${snapshot.data!.support.url}'),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'text : ${snapshot.data!.support.text}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Something error!'));
            }
          }
          // [end]
        },
      ),
    );
  }
}
