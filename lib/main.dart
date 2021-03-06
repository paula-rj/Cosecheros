import 'package:cosecheros/about.dart';
import 'package:cosecheros/harvests.dart';
import 'package:cosecheros/map.dart';
import 'package:cosecheros/new_harvest.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosecheros',
      theme: ThemeData(
        primaryColor: Color(0xFF01A0C7),
        accentColor: Color(0xFFFF00C7),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          padding: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))
          ),
        ),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({ Key key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Mapa'),
    Tab(text: 'Mis cosechas'),
    Tab(text: 'El proyecto')
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cosecheros de Granizo"),
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewHarvest()),
          );
        },
        tooltip: 'Nueva cosecha',
        child: Icon(Icons.add),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          MapRecent(),
          Harvests(),
          About(),
        ]
      ),
    );
  }
}