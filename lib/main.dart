import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Axolotl.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Axolotl',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Inspirational Axolotl'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Axolotl> futureAxolotl;

  Future<Axolotl> fetchAxolotl() async {
    print('new axolotl incoming');
    final response = await http
        .get(Uri.parse('https://axoltlapi.herokuapp.com/'));

    if (response.statusCode == 200) {
      print('new axolotl found');
      return Axolotl.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureAxolotl = fetchAxolotl();
  }

  void fetchNewAxolotl() {
    setState(() {
      futureAxolotl = fetchAxolotl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<Axolotl>(
        future: futureAxolotl,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Container(
                child: Image.network(snapshot.data!.imageUrl),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchNewAxolotl,
        tooltip: 'New Axolotl',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
