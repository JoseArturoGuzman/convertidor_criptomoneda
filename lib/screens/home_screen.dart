import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data.dart';
import '../services/networking.dart'; // Asegúrate de que la clase esté en este archivo o ajuste el path

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCurrency = "DOP";
  String? selectedCrypto = "BTC";
  final String apiKey = "03521bde-71de-4adf-bb4b-3de99b62c59b"; // Reemplaza con tu clave de API
  double? exchangeRate;
  late ExchangeRateService exchangeRateService;

  @override
  void initState() {
    super.initState();
    // Instancia el servicio de ExchangeRate
    exchangeRateService = ExchangeRateService(apiKey);
  }

  /// Actualiza el tipo de cambio usando el servicio
  void updateExchangeRate() async {
    if (selectedCrypto != null && selectedCurrency != null) {
      try {
        final rate = await exchangeRateService.fetchExchangeRate(selectedCrypto!, selectedCurrency!);
        setState(() {
          exchangeRate = rate;
        });
      } catch (e) {
        print("Error al actualizar el tipo de cambio: $e");
        setState(() {
          exchangeRate = 0.0; // Valor predeterminado en caso de error
        });
      }
    }
  }

  DropdownButton<String> getAndroidDropDownButton() {
    List<DropdownMenuItem<String>> dropdownItems = currentList.map((currency) {
      return DropdownMenuItem(
        value: currency,
        child: Text(currency, style: TextStyle(fontSize: 21),),
      );
    }).toList();

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          updateExchangeRate(); // Actualiza al cambiar la moneda
        });
      },
    );
  }

  DropdownButton<String> getCriptoAndroidDropDownButton() {
    List<DropdownMenuItem<String>> dropdownItems = criptoList.map((cripto) {
      return DropdownMenuItem(
        value: cripto,
        child: Text(cripto, style: TextStyle(fontSize: 21),),
      );
    }).toList();

    return DropdownButton<String>(
      value: selectedCrypto,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCrypto = value;
          updateExchangeRate(); // Actualiza al cambiar la moneda
        });
      },
    );
  }

  CupertinoPicker getIOSCupertinoPicker() {
    List<Text> pickerItems = currentList.map((currency) => Text(currency)).toList();

    return CupertinoPicker(
      backgroundColor: Colors.green,
      itemExtent: 32,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currentList[index];
          updateExchangeRate(); // Actualiza al cambiar la moneda
        });
      },
      children: pickerItems,
    );
  }

  CupertinoPicker getCriptoIOSCupertinoPicker() {
    List<Text> pickerItems = criptoList.map((cripto) => Text(cripto)).toList();

    return CupertinoPicker(
      backgroundColor: Colors.green,
      itemExtent: 32,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCrypto = currentList[index];
          updateExchangeRate(); // Actualiza al cambiar la moneda
        });
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Convertidor CriptoMoneda"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                child: Text(
                  exchangeRate == null
                      ? "Cargando... Por favor seleccione una moneda"
                      : "1 $selectedCrypto = ${exchangeRate!.toStringAsFixed(2)} $selectedCurrency",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(

            height: 150,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30),
            color: Colors.lightBlue,
            child: Row(
             mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Platform.isIOS ? getIOSCupertinoPicker() : getAndroidDropDownButton(),
             SizedBox(
               width: 50,
             ),
             Platform.isIOS ? getCriptoIOSCupertinoPicker() : getCriptoAndroidDropDownButton()
            ],
              )
          ),
        ],
      ),
    );
  }
}
