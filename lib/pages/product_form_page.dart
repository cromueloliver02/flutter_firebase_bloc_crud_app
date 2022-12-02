import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validators/validators.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import './pages.dart';
import '../utils/utils.dart';

class ProductFormPage extends StatelessWidget {
  static const id = '${HomePage.id}/product-form';

  const ProductFormPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductBloc, ProductState, ProductStatus>(
      selector: (state) => state.status,
      builder: (ctx, status) => WillPopScope(
        onWillPop: () async => status != ProductStatus.submitting,
        child: KeyboardDismisser(
          gestures: const [GestureType.onTap],
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Create New Product'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: _ProductForm(product: product),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductForm extends StatefulWidget {
  const _ProductForm({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;

  @override
  State<_ProductForm> createState() => _ProductPageFormState();
}

class _ProductPageFormState extends State<_ProductForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _description;
  int? _quantity;
  double? _price;
  XFile? _pickedImage;
  bool _isRecommended = false, _isPopular = false;

  @override
  void initState() {
    super.initState();
    _isRecommended = widget.product?.isRecommended ?? false;
    _isPopular = widget.product?.isPopular ?? false;
  }

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

      if (widget.product == null) {
        final createProductEvent = CreateProductEvent(
          name: _name!,
          description: _description!,
          image: _pickedImage!,
          quantity: _quantity!,
          price: _price!,
          isPopular: _isPopular,
          isRecommended: _isRecommended,
          dateCreated: DateTime.now(),
        );

        context.read<ProductBloc>().add(createProductEvent);
      }

      if (widget.product != null) {
        final newProduct = Product(
          id: widget.product!.id,
          name: _name!,
          description: _description!,
          imageUrl: widget.product!.imageUrl,
          quantity: _quantity!,
          price: _price!,
          isPopular: _isPopular,
          isRecommended: _isRecommended,
          dateCreated: widget.product!.dateCreated,
        );

        context.read<ProductBloc>().add(UpdateProductEvent(
              product: newProduct,
              image: _pickedImage,
            ));
      }
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

  void _productListener(BuildContext ctx, ProductState state) {
    if (state.status == ProductStatus.success) {
      Navigator.pop(context);
    }

    if (state.status == ProductStatus.error) {
      showErrorDialog(context, state.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocConsumer<ProductBloc, ProductState>(
        listener: _productListener,
        builder: (ctx, state) {
          final status = state.status;

          return Column(
            children: [
              CustomTextFormField(
                labelText: 'Name',
                hintText: 'Enter name',
                initialValue: widget.product?.name,
                prefixIcon: const Icon(Icons.edit),
                enabled: status != ProductStatus.submitting,
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
                enabled: status != ProductStatus.submitting,
                validator: _descriptionValidator,
                onSaved: (value) => _description = value,
              ),
              const SizedBox(height: 10),
              ImageFormField(
                value: widget.product?.imageUrl,
                enabled: status != ProductStatus.submitting,
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
                      enabled: status != ProductStatus.submitting,
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
                      enabled: status != ProductStatus.submitting,
                      validator: _priceValidator,
                      onSaved: (value) => _price = double.parse(value!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CheckboxField(
                labelText: 'Recommended',
                value: _isRecommended,
                enabled: status != ProductStatus.submitting,
                onChanged: (value) => setState(() => _isRecommended = value!),
              ),
              CheckboxField(
                labelText: 'Popular',
                value: _isPopular,
                enabled: status != ProductStatus.submitting,
                onChanged: (value) => setState(() => _isPopular = value!),
              ),
              const SizedBox(height: 10),
              CustomButton(
                labelText:
                    status == ProductStatus.submitting ? 'Saving...' : 'Save',
                onPressed: status == ProductStatus.submitting ? null : _submit,
              ),
            ],
          );
        },
      ),
    );
  }
}
