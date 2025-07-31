import 'package:flutter/material.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String price = '';
  String description = '';
  String imageUrl = '';
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter product name'
                    : null,
                onSaved: (value) => name = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter price' : null,
                onSaved: (value) => price = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
                onSaved: (value) => description = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Product Image URL',
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter image URL' : null,
                onSaved: (value) => imageUrl = value ?? '',
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? 'No date selected'
                          : 'Date: ${selectedDate!.toLocal()}'.split(' ')[0],
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
                          selectedDate = picked;
                        });
                      }
                    },
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // Handle the form data here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Product Added')),
                    );
                  } else if (selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a date')),
                    );
                  }
                },
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
