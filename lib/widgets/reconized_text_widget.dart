import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class RecognisedTextWidget extends StatelessWidget {
  final RecognisedText recognisedText;

  const RecognisedTextWidget({Key? key, required this.recognisedText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return scrollField(recognisedText);
  }

  // parsing widgets fields

  Widget scrollField(RecognisedText recognisedText) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (TextBlock block in recognisedText.blocks) blockWidget(block),
        ],
      ),
    );
  }

  Widget blockWidget(TextBlock block) {
    return Container(
      color: Colors.black38,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [for (TextLine line in block.lines) linekWidget(line)],
      ),
    );
  }

  Widget linekWidget(TextLine line) {
    return Container(
      margin: const EdgeInsets.all(1),
      color: Colors.black54,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            line.text,
            style:
                const TextStyle(color: Colors.white54, overflow: TextOverflow.fade),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}
