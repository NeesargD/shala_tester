import 'package:flutter/material.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  _ClassScreenState createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children:[
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
              Spacer(),
              IconButton(onPressed: (){}, icon: Icon(Icons.access_time)),
              IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border)),
            ]
          ),
        ],
      ),
    );
  }
}
