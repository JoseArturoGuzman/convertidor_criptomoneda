import 'dart:io';

import 'package:convertidor_criptomoneda/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String? selectedCurrency = "DOP";

  DropdownButton<String> getAndroidDropDownButton(){
    List<DropdownMenuItem<String>> dropdownItems = [];
    for(String currency in currentList){
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value){
          setState(() {
            selectedCurrency = value;
          });
        }
    );
  }

CupertinoPicker getIOSCupertinoPickcer(){

    List<Text> pickerItems = [];
    for(String currency in currentList){
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.green,
      itemExtent: 32,
      onSelectedItemChanged: (value) {

      },
      children: pickerItems,
    );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Convertidor CriptoMoneda"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                  child: Text(
                    "1 BTC = ? USD",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),)
              ),
            ),
          ),
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30),
            color: Colors.lightBlue,
            child: Platform.isIOS? getIOSCupertinoPickcer() :
            getAndroidDropDownButton(),
          ),
        ],
      ),
    );
  }
}