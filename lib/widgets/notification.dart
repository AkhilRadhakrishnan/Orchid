
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is
  //the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListTile',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String txt='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeeksforGeeks'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color:Colors.blue[50],
              child: ListTile(
                leading: const Icon(Icons.add),
                title: const Text('GFG title',textScaleFactor: 1.5,),
                trailing: const Icon(Icons.done),
                subtitle: const Text('This is subtitle'),
                selected: true,
                onTap: () {
                  setState(() {
                    txt='List Tile pressed';
                  });
                },
              ),
            ),
          ),
          Text(txt,textScaleFactor: 2,)
        ],
      ),
    );
  }
}