import 'package:intl/intl.dart';

extension CurrencyExtension on double {
  String reaisLabel() =>
      NumberFormat.currency(decimalDigits: 2, locale: 'pt-BR', symbol: 'R\$')
          .format(this);
}
