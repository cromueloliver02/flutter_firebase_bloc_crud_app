import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageFormField extends StatefulWidget {
  const ImageFormField({
    super.key,
    required this.value,
    required this.enabled,
    required this.onPickImage,
  });

  final String? value;
  final bool enabled;
  final void Function(XFile) onPickImage;

  @override
  State<ImageFormField> createState() => _ImageFormFieldState();
}

class _ImageFormFieldState extends State<ImageFormField> {
  String? _pickedImage;
  String? _errorMessage;

  void _pickImage(BuildContext ctx) async {
    final scaffoldMessenger = ScaffoldMessenger.of(ctx);
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('No image was selected')),
        );
    }

    if (image != null) {
      setState(() => _pickedImage = image.path);
      widget.onPickImage(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          height: 250,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              _PickImageButton(
                onSelectImage: () => _pickImage(context),
                enabled: widget.enabled,
              ),
              if (widget.value != null)
                CachedNetworkImage(
                  imageUrl: widget.value!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              if (_pickedImage != null)
                Image.asset(
                  _pickedImage!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
            ],
          ),
        ),
        if (_pickedImage != null || widget.value != null)
          TextButton(
            onPressed: widget.enabled ? () => _pickImage(context) : null,
            child: Text(
              'Change Image',
              style: textTheme.subtitle1!.copyWith(
                color: widget.enabled ? Colors.blue : Colors.grey,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        if (_errorMessage != null)
          Text(
            _errorMessage!,
            style: textTheme.bodyText1!.copyWith(
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}

class _PickImageButton extends StatelessWidget {
  const _PickImageButton({
    Key? key,
    required this.enabled,
    required this.onSelectImage,
  }) : super(key: key);

  final bool enabled;
  final VoidCallback onSelectImage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: enabled ? onSelectImage : null,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: enabled ? Colors.grey : Colors.grey.withAlpha(200),
                ),
              ),
              child: Icon(
                Icons.add_a_photo,
                size: 35,
                color: enabled ? Colors.grey : Colors.grey.withAlpha(200),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Pick An Image',
              style: textTheme.bodyText1!.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
