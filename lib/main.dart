import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();    // ADICIONE ESTA LINHA!
    });
  }

  void _calculateIMC(){
    setState(() {
      double weight = double.parse(weightController.text.replaceAll("-", "").replaceAll(",", "."));
      double height = double.parse(heightController.text.replaceAll("-", "").replaceAll(",", "."));
      double imc = weight / (height * height);
      atualizaStatusIMC(imc);
    });
  }

  void atualizaStatusIMC(double imc){
    if(imc < 18.6){
      _infoText = "Abaixo do peso (${imc.toStringAsFixed(4)})";
    }else if(imc >= 18.6 && imc < 24.9){
      _infoText = "Peso ideal (${imc.toStringAsFixed(4)})";
    }else if(imc >= 24.9 && imc < 29.9){
      _infoText = "Levemente acima do peso (${imc.toStringAsFixed(4)})";
    }else if(imc >= 29.9 && imc < 34.9){
      _infoText = "Obesidade grau I (${imc.toStringAsFixed(4)})";
    }else if(imc >= 34.9 && imc < 39.9){
      _infoText = "Obesidade grau II (${imc.toStringAsFixed(4)})";
    }else if(imc >= 40){
      _infoText = "Obesidade grau III (${imc.toStringAsFixed(4)})";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.00, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: weightController,
                validator: (value) {
                  if(value != null) {
                    if (value.isEmpty) {
                      value = value.replaceAll("-", "");
                      return "Insira sua altura!";
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: heightController,
                validator: (value) {
                  if(value != null) {
                    if (value.isEmpty) {
                      return "Insira seu peso!";
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState != null && _formKey.currentState!.validate()){
                      _calculateIMC();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: const EdgeInsets.all(14),
                  ),
                  child: const Text(
                    "Calcular",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
