import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investimento Paciência',
      theme: ThemeData(
        primarySwatch: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: InvestimentoPage(),
    );
  }
}

class InvestimentoPage extends StatefulWidget {
  @override
  _InvestimentoPageState createState() => _InvestimentoPageState();
}

class _InvestimentoPageState extends State<InvestimentoPage> {
  final _valorController = TextEditingController();
  final _mesesController = TextEditingController();
  final _taxaController = TextEditingController();

  double? montanteSemJuros;
  double? montanteComJuros;

  void calcular() {
    final valorMensal =
        double.tryParse(_valorController.text.replaceAll(',', '.')) ?? 0;
    final meses = int.tryParse(_mesesController.text) ?? 0;
    final taxa =
        double.tryParse(_taxaController.text.replaceAll(',', '.')) ?? 0;

    final semJuros = valorMensal * meses;

    double comJuros = 0;
    for (int i = 0; i < meses; i++) {
      comJuros = (comJuros + valorMensal) * (1 + taxa);
    }

    setState(() {
      montanteSemJuros = semJuros;
      montanteComJuros = comJuros;
    });
  }

  void resetar() {
    _valorController.clear();
    _mesesController.clear();
    _taxaController.clear();
    setState(() {
      montanteSemJuros = null;
      montanteComJuros = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Investimento Paciência')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .stretch, // faz os filhos ocuparem toda largura possível
          children: [
            TextField(
              controller: _valorController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Valor mensal para investir',
                prefixText: 'R\$ ',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _mesesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número de meses'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _taxaController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Taxa de juros mensal (ex: 0.01 = 1%)',
                suffixText: '%',
              ),
            ),
            SizedBox(height: 30),

            // Linha com os botões lado a lado
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: calcular,
                    child: Text('Calcular'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: resetar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade400,
                      foregroundColor: Colors.black87,
                    ),
                    child: Text('Resetar'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),
            if (montanteSemJuros != null)
              Text(
                'Montante sem juros: R\$ ${montanteSemJuros!.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            if (montanteComJuros != null)
              Text(
                'Montante com juros compostos: R\$ ${montanteComJuros!.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
          ],
        ),
      ),
    );
  }
}
