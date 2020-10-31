import 'dart:math';

import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe os dados";

  void _clearFields(){
      weightController.text = '';
      heightController.text = '';

      setState(() {
        _infoText = "Informe os dados";
        _formKey = GlobalKey<FormState>();
      });

  }


  void _calculate(){
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text)/100;

    double result = weight / (height*height);

    setState(() {
      if(result <18.6){
        _infoText = "Abaixo do peso ${result.toStringAsPrecision(3)}";
      }
      else if(result >=18.6 && result < 24.9){
        _infoText = "Peso ideal ${result.toStringAsPrecision(3)}";
      }
      else if(result >= 24.9 && result < 29.9 ){
        _infoText = "Levemente acima do peso ${result.toStringAsPrecision(3)}";
      }
      else if(result >= 29.9 && result < 34.9){
        _infoText = "Obesidade grau I ${result.toStringAsPrecision(3)}";
      }
      else if(result >= 34.9 && result < 39.9){
        _infoText = "Obesidade grau II ${result.toStringAsPrecision(3)}";
      }
      else if(result >= 39.9){
        _infoText = "Obesidade III ${result.toStringAsPrecision(3)}";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _clearFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (em KG)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu peso";
                  }
                  return null;
                },
              ),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (em CM)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green),
                controller: heightController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira sua altura";
                    }
                    return null;
                  }
              ),
              Padding(
                padding: EdgeInsets.only(top:10.0,bottom: 10.0),
                child: Container(
                  height: 45.0,
                  child:
                  RaisedButton(onPressed: (){
                    if(_formKey.currentState.validate()){
                      _calculate();
                    }
                  },
                    child: Text("Calcular",
                        style: TextStyle(color: Colors.white,fontSize: 25.0)),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color:Colors.green,fontSize: 25.0)
              )
            ],
          ),
        )
      )
    );
  }
}






