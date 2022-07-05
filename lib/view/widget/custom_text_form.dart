import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextForm extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final RxString input;
  const CustomTextForm({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.input,
  }) : super(key: key);

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        hintText: widget.hintText,
      ),
      onChanged: (val) {
        widget.input.value = val;
      },
    );
  }
}
