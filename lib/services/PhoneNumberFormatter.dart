import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
else{
    int count = 4;
    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % count == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
        count += 3; // Add single space.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
  }
}
