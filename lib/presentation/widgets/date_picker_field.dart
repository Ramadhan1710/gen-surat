import 'package:flutter/material.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? helpText;
  final String hint;
  final String? Function(String?)? validator;

  const DatePickerField({
    super.key,
    required this.controller,
    this.helpText,
    required this.label,
    required this.hint,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      label: label,
      helpText: helpText,
      hint: hint,
      textCapitalization: TextCapitalization.words,
      suffixIcon: IconButton(
        icon: const Icon(Icons.calendar_today),
        onPressed: () => _selectDate(context),
      ),
      validator: validator,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(picked);
      controller.text = formattedDate;
    }
  }
}
