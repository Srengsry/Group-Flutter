import 'package:flutter/material.dart';
import 'product_model.dart';

class AddCategoryForm extends StatefulWidget {
  const AddCategoryForm({super.key});

  @override
  State<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  int? id;
  String name = '';
  int? categoryId;
  int? brandId;
  String model = '';
  String? serialNumber;
  double? purchasePrice;
  double? sellingPrice;
  int stockQuantity = 0;
  ProductStatus status = ProductStatus.available;
  DateTime? purchaseDate;
  DateTime? warrantyExpiry;
  String? description;
  String? imagePath;
  DateTime? createdAt;
  DateTime? updatedAt;

  final List<String> categories = [
    'Electronics',
    'Clothing',
    'Books',
    'Home',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Category')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Category Name'),
                  items: categories
                      .map(
                        (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => name = value ?? ''),
                  validator: (value) =>
                      value == null ? 'Select a category' : null,
                  onSaved: (value) => name = value ?? '',
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Model'),
                  onSaved: (value) => model = value ?? '',
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Serial Number'),
                  onSaved: (value) => serialNumber = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Purchase Price',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) =>
                      purchasePrice = double.tryParse(value ?? ''),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Selling Price'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) =>
                      sellingPrice = double.tryParse(value ?? ''),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Stock Quantity',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) =>
                      stockQuantity = int.tryParse(value ?? '') ?? 0,
                ),
                DropdownButtonFormField<ProductStatus>(
                  decoration: const InputDecoration(labelText: 'Status'),
                  value: status,
                  items: ProductStatus.values
                      .map(
                        (s) => DropdownMenuItem(
                          value: s,
                          child: Text(s.toString().split('.').last),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => status = value ?? ProductStatus.available),
                  onSaved: (value) => status = value ?? ProductStatus.available,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 2,
                  onSaved: (value) => description = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Image Path'),
                  onSaved: (value) => imagePath = value,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        purchaseDate == null
                            ? 'No purchase date selected'
                            : 'Purchase Date: ${purchaseDate!.toLocal()}'.split(
                                ' ',
                              )[0],
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          setState(() {
                            purchaseDate = picked;
                          });
                        }
                      },
                      child: const Text('Select Purchase Date'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        warrantyExpiry == null
                            ? 'No warranty expiry selected'
                            : 'Warranty Expiry: ${warrantyExpiry!.toLocal()}'
                                  .split(' ')[0],
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          setState(() {
                            warrantyExpiry = picked;
                          });
                        }
                      },
                      child: const Text('Select Warranty Expiry'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      final product = Product(
                        id: id,
                        name: name,
                        categoryId: categoryId,
                        brandId: brandId,
                        model: model,
                        serialNumber: serialNumber,
                        purchasePrice: purchasePrice,
                        sellingPrice: sellingPrice,
                        stockQuantity: stockQuantity,
                        status: status,
                        purchaseDate: purchaseDate,
                        warrantyExpiry: warrantyExpiry,
                        description: description,
                        imagePath: imagePath,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );
                      // Example usage: print the product to console
                      print(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Category Added')),
                      );
                    }
                  },
                  child: const Text('Add Category'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
