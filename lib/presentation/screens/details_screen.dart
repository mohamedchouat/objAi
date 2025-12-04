import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/utils.dart';
import '../../domain/entities/scan_entity.dart';

class DetailsScreen extends StatelessWidget {
  final ScanEntity scan;
  const DetailsScreen({super.key, required this.scan});

  void _share() => SharePlus.instance.share(ShareParams(text: '${scan.objectName}\n\n${scan.description}\n\nFrom ObjAI'));

  Future<void> _openWikipedia() async {
    final url = Uri.parse('https://en.wikipedia.org/wiki/${Uri.encodeComponent(scan.objectName)}');
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scan.objectName),
        actions: [
          IconButton(onPressed: _share, icon: const Icon(Icons.share)),
          IconButton(onPressed: _openWikipedia, icon: const Icon(Icons.open_in_browser)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(File(scan.originalImagePath), height: 260, fit: BoxFit.cover),
          ),
          const SizedBox(height: 12),
          Text(scan.objectName, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(formatDate(scan.date), style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          if (scan.wikiImageUrl != null && scan.wikiImageUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(scan.wikiImageUrl!, fit: BoxFit.cover, height: 160),
            ),
          const SizedBox(height: 12),
          Text(scan.description, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _openWikipedia,
            icon: const Icon(Icons.open_in_browser),
            label: const Text('Open on Wikipedia'),
          ),
        ],
      ),
    );
  }
}
