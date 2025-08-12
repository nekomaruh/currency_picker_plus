import 'package:currency_picker_plus/src/widgets/components/currency_search_bar.dart';
import 'package:flutter/material.dart';

import '../../../currency_picker_plus.dart';

class CurrencyModalContent extends StatefulWidget {
  /// Service to load lsit
  /// Injected from [CurrencyPicker]
  final CurrencyService currencyService;

  /// Called when a currency is select.
  /// The currency picker passes the new value to the callback.
  final ValueChanged<Currency> onSelect;

  /// The Currencies that will appear at the top of the list (optional).
  /// It takes a list of Currency code.
  final List<String>? favorite;

  /// Can be used to uses filter the Currency list (optional).
  /// It takes a list of Currency code.
  final List<String>? currencyFilter;

  /// Shows flag for each currency (optional).
  /// Defaults true.
  final bool showFlag;

  /// Shows currency name (optional).
  /// [showCurrencyName] and [showCurrencyCode] cannot be both false
  /// Defaults true.
  final bool showCurrencyName;

  /// Shows currency code (optional).
  /// [showCurrencyCode] and [showCurrencyName] cannot be both false
  /// Defaults true.
  final bool showCurrencyCode;

  /// To disable the search TextField (optional).
  final bool showSearchField;

  /// Hint of the search TextField (optional).
  /// Defaults Search.
  final String? searchHint;

  final ScrollController? controller;

  final ScrollPhysics? physics;

  /// An optional argument for for customizing the
  /// currency list bottom sheet.
  final CurrencyPickerThemeData? theme;

  final bool showDragHandle;

  final bool showSearchDivider;

  final bool showKeyboard;

  const CurrencyModalContent({
    super.key,
    required this.onSelect,
    required this.currencyService,
    this.favorite,
    this.currencyFilter,
    this.showSearchField = true,
    this.searchHint,
    this.showCurrencyCode = true,
    this.showCurrencyName = true,
    this.showFlag = true,
    this.showDragHandle = false,
    this.showSearchDivider = false,
    this.physics,
    this.controller,
    this.theme,
    this.showKeyboard = false,
  });

  @override
  CurrencyModalContentState createState() => CurrencyModalContentState();
}

class CurrencyModalContentState extends State<CurrencyModalContent> {
  List<Currency> _filteredList = [];
  List<Currency> _currencyList = [];
  List<Currency>? _favoriteList;
  TextEditingController? _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();

    _currencyList = List.from(widget.currencyService.getAll());

    if (widget.currencyFilter != null) {
      final currencyFilter = widget.currencyFilter!
          .map((code) => code.toUpperCase())
          .toList();

      _currencyList.removeWhere(
        (element) => !currencyFilter.contains(element.code),
      );
    }

    if (widget.favorite != null) {
      _favoriteList = widget.currencyService.findCurrenciesByCode(
        widget.favorite!,
      );
    }

    _filteredList.addAll(_currencyList);
    super.initState();
  }

  @override
  void dispose() {
    _searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: widget.showDragHandle ? 0 : 20,
            bottom: widget.showDragHandle ? 15 : 15,
          ),
          child: CurrencySearchBar(
            autofocus: widget.showKeyboard,
            visible: widget.showSearchField,
            controller: _searchController,
            onFilter: _filterSearchResults,
          ),
        ),
        Visibility(visible: widget.showSearchDivider, child: Divider()),

        Expanded(
          child: ListView(
            physics: widget.physics,
            controller: widget.controller,
            children: [
              if (_favoriteList != null) ...[
                ..._favoriteList!.map(
                  (currency) => CurrencyListItem(
                    currency: currency,
                    onSelect: widget.onSelect,
                    showFlag: widget.showFlag,
                    showCode: widget.showCurrencyCode,
                    showName: widget.showCurrencyName,
                    theme: widget.theme,
                  ),
                ),
                const Padding(padding: EdgeInsets.zero, child: Divider()),
              ],
              ..._filteredList.map(
                (currency) => CurrencyListItem(
                  currency: currency,
                  onSelect: widget.onSelect,
                  showFlag: widget.showFlag,
                  showCode: widget.showCurrencyCode,
                  showName: widget.showCurrencyName,
                  theme: widget.theme,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  void _filterSearchResults(String query) {
    List<Currency> searchResult = [];

    if (query.isEmpty) {
      searchResult.addAll(_currencyList);
    } else {
      searchResult = _currencyList
          .where(
            (c) =>
                c.name.toLowerCase().contains(query.toLowerCase().trim()) ||
                c.code.toLowerCase().contains(query.toLowerCase().trim()),
          )
          .toList();
    }

    setState(() => _filteredList = searchResult);
  }
}
