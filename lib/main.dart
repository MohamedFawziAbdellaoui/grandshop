import 'package:flutter/material.dart';
import 'package:grandshop/service/api_service.dart';
import 'package:grandshop/ui/sign_in.dart';
import 'package:grandshop/ui/sign_up.dart';
import 'models/categories.dart';
import 'models/commande.dart';
import 'models/produits.dart';
import 'models/sous_categories.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int selected;
  late int selectedIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = 0;
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SignIn.id,
      routes: {
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
      },
    );
  }
}
