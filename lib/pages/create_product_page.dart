// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';
import './pages.dart';

class CreateProductPage extends StatelessWidget {
  static const id = '${HomePage.id}/create-product';

  const CreateProductPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [GestureType.onTap],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create New Product'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: _ProductPageForm(product: product),
        ),
      ),
    );
  }
}

class _ProductPageForm extends StatefulWidget {
  const _ProductPageForm({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;

  @override
  State<_ProductPageForm> createState() => _ProductPageFormState();
}

class _ProductPageFormState extends State<_ProductPageForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _description;
  int? _quantity;
  double? _price;
  String? _pickedImage;
  bool _isRecommended = false, _isPopular = false;

  void _submit() {
    final form = _formKey.currentState;

    if (widget.product?.imageUrl == null) {
      if (_pickedImage == null) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Please selected an image')),
          );
      }
    }

    if (form == null || form.validate()) {
      form!.save();

      // print('_name $_name');
      // print('_description $_description');
      // if (_pickedImage == null) {
      //   print('widget.product?.imageUrl ${widget.product?.imageUrl}');
      // } else {
      //   print('_pickedImage $_pickedImage');
      // }
      // print('_quantity $_quantity');
      // print('_price $_price');
      // print('_isRecommended $_isRecommended');
      // print('_isPopular $_isPopular');
    }
  }

  String? _nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';

    if (value.trim().length < 6) {
      return 'Name must be at least 6 characters long';
    }

    return null;
  }

  String? _descriptionValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Description is required';

    if (value.trim().length < 6) {
      return 'Description must be at least 12 characters long';
    }

    return null;
  }

  String? _quantityValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Description is required';

    if (!isNumeric(value)) {
      return 'Invalid quantity';
    }

    return null;
  }

  String? _priceValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Price is required';

    if (double.tryParse(value) == null) {
      return 'Invalid price';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        reverse: true,
        children: [
          CustomTextFormField(
            labelText: 'Name',
            hintText: 'Enter name',
            initialValue: widget.product?.name,
            prefixIcon: const Icon(Icons.edit),
            validator: _nameValidator,
            onSaved: (value) => _name = value,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            labelText: 'Description',
            hintText: 'Enter description',
            maxLines: 6,
            initialValue: widget.product?.description,
            prefixIcon: const Icon(Icons.note),
            validator: _descriptionValidator,
            onSaved: (value) => _description = value,
          ),
          const SizedBox(height: 10),
          ImageFormField(
            value: widget.product?.imageUrl,
            onPickImage: (value) => _pickedImage = value,
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextFormField(
                  labelText: 'Quantity',
                  hintText: 'Enter quantity',
                  keyboardType: TextInputType.number,
                  initialValue: widget.product?.quantity.toString(),
                  prefixIcon: const Icon(Icons.numbers),
                  validator: _quantityValidator,
                  onSaved: (value) => _quantity = int.parse(value!),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomTextFormField(
                  labelText: 'Price',
                  hintText: 'Enter price',
                  initialValue: widget.product?.price.toStringAsFixed(2),
                  prefixIcon: const Icon(Icons.price_check),
                  validator: _priceValidator,
                  onSaved: (value) => _price = double.parse(value!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CheckboxField(
            labelText: 'Recommended',
            value: widget.product?.isRecommended ?? _isRecommended,
            onChanged: (value) => setState(() => _isRecommended = value!),
          ),
          CheckboxField(
            labelText: 'Popular',
            value: widget.product?.isPopular ?? _isPopular,
            onChanged: (value) => setState(() => _isPopular = value!),
          ),
          const SizedBox(height: 10),
          CustomButton(
            labelText: 'Save',
            onPressed: _submit,
          ),
        ].reversed.toList(),
      ),
    );
  }
}
