import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_typeahead_demo/state_servies.dart';

import 'api/user_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Typeahead Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuickSearchScreen(),
    );
  }
}

class QuickSearchScreen extends StatefulWidget {
  const QuickSearchScreen({Key? key}) : super(key: key);

  @override
  _QuickSearchScreenState createState() => _QuickSearchScreenState();
}

class _QuickSearchScreenState extends State<QuickSearchScreen> {
  String? userSelected;
  final TextEditingController mycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(right: 18.0, top: 8),
            child: SizedBox(
                height: 40,
                width: double.infinity,
                child: TypeAheadField<User?>(
                  hideSuggestionsOnKeyboardHide: false,
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      hintText: 'Search Username',
                    ),
                  ),
                  suggestionsCallback: UserApi.getUserSuggestions,
                  itemBuilder: (context, User? suggestion) {
                    final user = suggestion!;

                    return ListTile(
                      title: Text(user.name),
                    );
                  },
                  noItemsFoundBuilder: (context) => Container(
                    height: 100,
                    child: Center(
                      child: Text(
                        'No Users Found.',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  onSuggestionSelected: (User? suggestion) {
                    final user = suggestion!;

                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text('Selected user: ${user.name}'),
                      ));
                  },
                )),
          ),
        ),
        body: Center(
          child: Text(
            userSelected ?? 'Search',
            style: const TextStyle(fontSize: 20),
          ),
        ));
  }
}
