import 'package:flutter/material.dart';
import 'package:gen_surat/core/models/form_field_model.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/date_picker_field.dart';

class FocusFormField extends StatelessWidget {
  final List<FormFieldModel> fields;
  final void Function(FocusNode current, FocusNode next) onNext;

  const FocusFormField({super.key, required this.fields, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          fields.map((f) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spaceM),
              child:
                  f.isDatePicker
                      ? DatePickerField(
                        controller: f.controller,
                        label: f.label,
                        helpText: f.helpText,
                        hint: f.hint,
                        validator: f.validator,
                        focusNode: f.focusNode,
                        textInputAction:
                            f.nextFocus != null
                                ? TextInputAction.next
                                : TextInputAction.done,
                        onFieldSubmitted: (_) {
                          if (f.nextFocus != null) {
                            onNext(f.focusNode, f.nextFocus!);
                          } else {
                            f.focusNode.unfocus();
                          }
                        },
                      )
                      : CustomTextField(
                        controller: f.controller,
                        focusNode: f.focusNode,
                        label: f.label,
                        hint: f.hint,
                        helpText: f.helpText,
                        icon: f.icon,
                        keyboardType: f.keyboard,
                        validator: f.validator,
                        textInputAction:
                            f.nextFocus != null
                                ? TextInputAction.next
                                : TextInputAction.done,
                        onFieldSubmitted: (_) {
                          if (f.nextFocus != null) {
                            onNext(f.focusNode, f.nextFocus!);
                          } else {
                            f.focusNode.unfocus();
                          }
                        },
                      ),
            );
          }).toList(),
    );
  }
}
