import 'package:currency_picker_plus/currency_picker_plus.dart';

final service = CurrencyService.instance;

final eurMock = service.findByCode("EUR")!;
final usdMock = service.findByCode("USD")!;
final jpyMock = service.findByCode("JPY")!;
final brlMock = service.findByCode("BRL")!;
final clpMock = service.findByCode("CLP")!;
final mxnMock = service.findByCode("MXN")!;
