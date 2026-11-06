import 'package:flutter/material.dart';
import '../models/profile_data.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.initialProfile});
  final ProfileData initialProfile;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final _nameController = TextEditingController(text: widget.initialProfile.name);
  late final _titleController = TextEditingController(text: widget.initialProfile.title);
  late final _bioController = TextEditingController(text: widget.initialProfile.bio);

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final updated = ProfileData(
                name: _nameController.text.trim(),
                title: _titleController.text.trim(),
                bio: _bioController.text.trim(),
              );
              Navigator.pop(context, updated);
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nama Lengkap'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Jabatan / Title'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _bioController,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Bio'),
          ),
        ],
      ),
    );
  }
}