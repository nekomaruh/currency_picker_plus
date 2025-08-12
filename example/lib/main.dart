import 'package:currency_picker_plus/currency_picker_plus.dart';
import 'package:flutter/material.dart';

final currencyService = CurrencyService.instance;
final showSymbol = true;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Example());
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  late Currency _currency;

  @override
  initState() {
    super.initState();
    _currency = currencyService.findByCode("USD")!;
  }

  updateCurrency(Currency currency) {
    setState(() => _currency = currency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Currency Picker Plus Example")),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            'Currency: ${_currency.code}',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          _ShowInput(currency: _currency),
          SizedBox(height: 40),
          _ShowFlags(currency: _currency),
          SizedBox(height: 40),
          IntrinsicWidth(
            child: FilledButton(
              onPressed: () {
                // Prefeer Inject CurrencyService with DI
                // Default internally will be generated
                showCurrencyBottomSheet(
                  context: context,
                  currencyService: currencyService,
                  onSelect: updateCurrency,
                  autofocusKeyboard: true,
                );
              },
              child: Text('Select Currency'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShowFlags extends StatelessWidget {
  final Currency currency;

  const _ShowFlags({required this.currency});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 30,
      runSpacing: 30,
      alignment: WrapAlignment.center,
      children: [
        Column(
          children: [
            Text('ASSET NORMAL'),
            SizedBox(height: 10),
            CurrencyAssetFlag(currency: currency),
          ],
        ),
        Column(
          children: [
            Text('ASSET CIRCLE'),
            SizedBox(height: 10),
            CurrencyAssetFlagCircular(currency: currency),
          ],
        ),
        Column(
          children: [
            Text('EMOJI TEXT'),
            CurrencyEmojiFlag(currency: currency),
          ],
        ),
      ],
    );
  }
}

class _ShowInput extends StatefulWidget {
  final Currency currency;

  const _ShowInput({required this.currency});

  @override
  State<_ShowInput> createState() => _ShowInputState();
}

class _ShowInputState extends State<_ShowInput> {
  String _formattedValue = '';
  String _unformattedValue = '';

  onUpdate(CurrencyFormatter formatter) {
    setState(() {
      _formattedValue = formatter.getFormattedValue();
      _unformattedValue = formatter.getUnformattedValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text('FORMATTED: $_formattedValue'),
        Text('UNFORMATTED: $_unformattedValue'),
        IntrinsicWidth(
          child: CurrencyInput(currency: widget.currency, onChange: onUpdate),
        ),
      ],
    );
  }
}

class CurrencyInput extends StatefulWidget {
  final Currency currency;
  final ValueChanged<CurrencyFormatter> onChange;

  const CurrencyInput({
    super.key,
    required this.currency,
    required this.onChange,
  });

  @override
  State<CurrencyInput> createState() => _CurrencyInputState();
}

class _CurrencyInputState extends State<CurrencyInput> {
  late TextEditingController _controller;
  late CurrencyFormatter _formatter;

  @override
  void initState() {
    debugPrint("INIT STATE: ${widget.currency.code}");
    super.initState();
    _createFormatter();
    _controller = TextEditingController();
    _controller.addListener(() => widget.onChange(_formatter));
  }

  void _createFormatter() {
    _formatter = formatterFromCurrency(
      currency: widget.currency,
      showSymbol: showSymbol,
    );
  }

  @override
  void didUpdateWidget(covariant CurrencyInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currency != widget.currency) {
      final oldUnformatted = _formatter.getUnformattedValue();
      _createFormatter();
      final newFormatted = _formatter.formatString(oldUnformatted);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.value = TextEditingValue(text: newFormatted);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      inputFormatters: [_formatter],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: widget.currency.emptyPlaceholder(showSymbol: showSymbol),
      ),
    );
  }
}
