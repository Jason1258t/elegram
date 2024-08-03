import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messenger_test/utils/fonts.dart';

class TextFieldName extends StatefulWidget {
  final TextEditingController controller;
  final InputDecoration decoration;
  final List<String> takenNames;

  const TextFieldName({
    super.key,
    required this.controller,
    required this.decoration,
    required this.takenNames,
  });

  @override
  _TextFieldNameState createState() => _TextFieldNameState();
}

class _TextFieldNameState extends State<TextFieldName> {
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: widget.controller,
        decoration: widget.decoration.copyWith(
          errorText: _errorMessage,
          errorStyle: AppTypography.fontHeadline16w500.copyWith(color: Colors.red)
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(26),
        ],
        keyboardType: TextInputType.text,
        style: AppTypography.fontHeadlineW17w400,
        validator: (value) {
          if (value == null) {
            return null;
          }
          return NameValidator.validate(value, widget.takenNames);
        },
        onChanged: (value) {
          setState(() {
            _errorMessage = NameValidator.validate(value, widget.takenNames);
          });
        },
      ),
    );
  }
}

class NameValidator {
  static List<String> bannedWords = [
    'badword1',
    'badword2',
    'badword3'
  ];

  static String? validate(String value, List<String> takenNames) {
    if (value.isEmpty) {
      return 'Name cannot be empty';
    }
    if (value.length > 25) {
      return 'Name must be 25 characters or less.';
    }
    if (value.contains(' ')) {
      return 'Name cannot contain spaces.';
    }
    if (value.startsWith(RegExp(r'[^\w]'))) {
      return 'Name cannot start with special characters.';
    }
    for (var word in bannedWords) {
      if (value.toLowerCase().contains(word)) {
        return 'Name contains inappropriate content.';
      }
    }
    if (takenNames.contains(value)) {
      return 'Name is already taken.';
    }
    return null;
  }
}
