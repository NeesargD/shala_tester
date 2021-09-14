import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shala_yoga/base/utils/constants/textstyle_constants.dart';

class ExpandShrinkText extends StatefulWidget {
  const ExpandShrinkText(this.text,{Key? key,  this.trimLines = 3}) : assert(text != null),super(key:
  key);

  final String text;
  final int trimLines;

  @override
  _ExpandShrinkTextState createState() => _ExpandShrinkTextState();
}

class _ExpandShrinkTextState extends State<ExpandShrinkText> {

  bool textDescription = true;

  void onTap(){
    setState(() {
      textDescription = !textDescription;
    });
  }

  @override
  Widget build(BuildContext context) {

    TextSpan link = TextSpan(
        text: textDescription ? " show more" : " show less",
        style: TextStyles.R1578,
        recognizer: TapGestureRecognizer()..onTap = onTap
    );

Widget textResult = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          assert(constraints.hasBoundedWidth);
          final double maxWidth = constraints.maxWidth;
          final text = TextSpan(
            text: widget.text,
          );
          TextPainter textPainter = TextPainter(
            text: link,
            textDirection: TextDirection.rtl,
            maxLines: widget.trimLines,
            ellipsis: '...',
          );
          textPainter.layout(
              minWidth: constraints.minWidth, maxWidth: maxWidth);
          final linkSize = textPainter.size;
          // Layout and measure text
          textPainter.text = text;
          textPainter.layout(minWidth: constraints.minWidth, maxWidth:maxWidth);
          final textSize = textPainter.size;
          // Get the endIndex of data
          int endIndex;
          final pos = textPainter.getPositionForOffset(Offset(
            textSize.width - linkSize.width,
            textSize.height,
          ));
          endIndex = textPainter.getOffsetBefore(pos.offset)!;
          var textSpan;
          if (textPainter.didExceedMaxLines) {
            textSpan = TextSpan(
              text: textDescription
                  ? widget.text.substring(0, endIndex)
                  : widget.text,
              style: TextStyles.R1375,
              children:<TextSpan>[link],
            );
          } else {
            textSpan = TextSpan(
              text: widget.text,
            );
          }
          return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text:textSpan,
          );
        },
    );
    return textResult;
  }
}

