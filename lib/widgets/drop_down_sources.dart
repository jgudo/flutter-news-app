import 'package:flutter/material.dart';

class DropDownSources extends StatefulWidget {
  @override
  _DropDownSourcesState createState() => _DropDownSourcesState();
}

class _DropDownSourcesState extends State<DropDownSources> {
  String _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: DropdownButton<String>(
        value: _chosenValue,
        //elevation: 5,
        style: TextStyle(color: Colors.black),
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.white,
        items: <String>[
          'BBC',
          'Rappler',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
        }).toList(),
        hint: Text(
          "Select Source",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onChanged: (String value) {
          setState(() {
            _chosenValue = value;
          });
        },
      ),
    );
  }
}
