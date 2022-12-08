import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum GetImageFrom { camera, gallery }

class UserImagePicker extends StatefulWidget {
  final void Function(File image) onImagePick;
  const UserImagePicker({super.key, required this.onImagePick});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _image;

  void _pickImage(GetImageFrom imageFrom) async {
    final ImagePicker picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(
      source: imageFrom == GetImageFrom.gallery
          ? ImageSource.gallery
          : ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (imageFile == null) return;

    setState(() {
      _image = File(imageFile.path);
    });

    widget.onImagePick(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? FileImage(_image!) : null,
        ),
        Row(
          children: [
            TextButton.icon(
              onPressed: () => _pickImage(GetImageFrom.gallery),
              icon: const Icon(Icons.image),
              label:
                  Text(_image == null ? 'Adicionar Imagem' : 'Alterar imagem'),
            ),
            TextButton.icon(
              onPressed: () => _pickImage(GetImageFrom.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Tirar uma foto'),
            ),
          ],
        )
      ],
    );
  }
}
