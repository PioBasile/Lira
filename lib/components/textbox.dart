import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  final String text;
  final double initialFontSize;

  const TextBox({
    super.key,
    required this.text,
    this.initialFontSize = 16.0,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  late double _fontSize;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _fontSize = widget.initialFontSize;
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _increaseFontSize() {
    setState(() {
      _fontSize += 1;
    });
  }

  void _decreaseFontSize() {
    setState(() {
      if (_fontSize > 1) {
        _fontSize -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adjustable Text Box'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _increaseFontSize,
          ),
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _decreaseFontSize,
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: _fontSize,
              color: Colors.grey[200], // A lighter shade of white for better readability.
            ),
          ),
        ),
      ),
    );
  }
}
