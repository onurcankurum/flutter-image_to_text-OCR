// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanalogi/widgets/reconized_text_widget.dart';

class OcrScreen extends StatefulWidget {
  const OcrScreen({Key? key}) : super(key: key);

  @override
  _OcrScreenState createState() => _OcrScreenState();
}

class _OcrScreenState extends State<OcrScreen> {
  final ImagePicker _picker = ImagePicker();
  final _textDetector = GoogleMlKit.vision.textDetector();
  RecognisedText? recognisedText;
  XFile? _imageFile;

  Future<RecognisedText> _imageToText(XFile image) async {
    final inputImage = InputImage.fromFilePath(_imageFile!.path);
    return await _textDetector.processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return scaffold;
  }
  //  local widgets

  Widget get scaffold => Scaffold(
        appBar: AppBar(
          title: const Text("Hello OCR"),
        ),
        body: Column(
          children: [
            Expanded(flex: 1, child: imageField),
            Expanded(flex: 1, child: textField)
          ],
        ),
      );

  Widget get imageField => Container(
      color: Colors.blue,
      child: Column(
        children: [
          Expanded(flex: 5, child: image),
          Expanded(flex: 1, child: imagePickerkButton)
        ],
      ));

  Widget get image => Container(
      color: Colors.blueGrey,
      child: _imageFile != null
          ? Image.file(
              new File(_imageFile!.path),
            )
          : Container());

  Widget get imagePickerkButton => ElevatedButton(
      onPressed: () async {
        _imageFile = await _picker.pickImage(source: ImageSource.gallery);
        if (_imageFile != null) {
          _imageToText(_imageFile!).then((value) {
            setState(() {
              recognisedText = value;
            });
          });
        }
      },
      child: Text("pick an image"));

  Widget get textField => Container(
        color: Colors.black26,
        width: double.infinity,
        child: recognisedText == null
            ? Container()
            : RecognisedTextWidget(
                recognisedText: recognisedText!,
              ),
      );
}
