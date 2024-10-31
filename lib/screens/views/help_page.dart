import 'package:flutter/material.dart';
import 'package:mark_soc/widgets/my_app_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HelpPage extends StatefulWidget {
  final String assetPath;

  const HelpPage({super.key, required this.assetPath});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    preparePDF();
  }

  Future<void> preparePDF() async {
    final bytes = await rootBundle.load(widget.assetPath);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${widget.assetPath.split('/').last}');

    await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);
    setState(() {
      localPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title:"Guide d'utilisation",
      ),
      body: localPath != null
          ? SfPdfViewer.file(File(localPath!))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
