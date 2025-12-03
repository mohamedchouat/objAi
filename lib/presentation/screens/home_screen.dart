import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/utils.dart';
import '../providers.dart';
import 'details_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        ref.read(historyProvider.notifier).load();
      } catch (e) {
        print('Error loading history: $e');
      }
    });
  }

  Future<void> _scanFromCamera() async {
    final picked = await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (picked == null) return;
    _handleFile(File(picked.path));
  }

  Future<void> _pickFromGallery() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked == null) return;
    _handleFile(File(picked.path));
  }

  Future<void> _handleFile(File file) async {
    showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()), barrierDismissible: false);
    try {
      final result = await ref.read(historyProvider.notifier).detectAndSave(file);
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailsScreen(scan: result)));
    } catch (e) {
      // Log the error for debugging purposes
      print('Object detection failed: $e');
      
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Scan failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(historyProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('ObjAI')),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _scanFromCamera,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Camera'),
              ),
              ElevatedButton.icon(
                onPressed: _pickFromGallery,
                icon: const Icon(Icons.photo),
                label: const Text('Gallery'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: history.isEmpty
                ? const Center(child: Text('No history yet'))
                : ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, i) {
                      final item = history[i];
                      return ListTile(
                        leading: SizedBox(
                          width: 64,
                          height: 64,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(File(item.originalImagePath), fit: BoxFit.cover),
                          ),
                        ),
                        title: Text(item.objectName),
                        subtitle: Text(item.description.length > 80 ? '${item.description.substring(0, 80)}...' : item.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(formatDate(item.date)),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => ref.read(historyProvider.notifier).delete(item.id),
                            ),
                          ],
                        ),
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailsScreen(scan: item))),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}