import 'package:flutter/material.dart';

class MultiSelectItem {
  final String value;
  final String label;

  const MultiSelectItem({
    required this.value,
    required this.label,
  });
}

class MultiSelect extends StatefulWidget {
  final List<MultiSelectItem> items;
  final List<String> selectedItems;

  const MultiSelect({
    required this.items,
    required this.selectedItems,
  });

  @override
  State<MultiSelect> createState() => MultiSelectState();
}

class MultiSelectState extends State<MultiSelect> {
  late List<String> items;

  @override
  void initState() {
    super.initState();
    items = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecionar Países'),
      content: SingleChildScrollView(
        child: Column(
          children: widget.items.map((item) {
            return CheckboxListTile(
              value: items.contains(item.value),
              title: Text(item.label),
              onChanged: (isChecked) {
                setState(() {
                  if (isChecked ?? false) {
                    items.add(item.value);
                  } else {
                    items.remove(item.value);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(items),
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
