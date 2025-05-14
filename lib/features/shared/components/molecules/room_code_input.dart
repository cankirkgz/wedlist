import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class RoomCodeInput extends StatefulWidget {
  final int length;

  final ValueChanged<String>? onCompleted;

  final ValueChanged<String>? onChanged;

  const RoomCodeInput({
    Key? key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
  })  : assert(length > 0),
        super(key: key);

  @override
  State<RoomCodeInput> createState() => _RoomCodeInputState();
}

class _RoomCodeInputState extends State<RoomCodeInput> {
  late final List<FocusNode> _focusNodes;
  late final List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_focusNodes.isNotEmpty) _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (i) {
        return Padding(
          padding: EdgeInsets.only(left: i == 0 ? 0 : AppSizes.paddingSm),
          child: SizedBox(
            width: AppSizes.widthSm,
            height: AppSizes.heightXl,
            child: TextField(
              controller: _controllers[i],
              focusNode: _focusNodes[i],
              keyboardType: TextInputType.text,
              textInputAction: i == widget.length - 1
                  ? TextInputAction.done
                  : TextInputAction.next,
              maxLength: 1,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                UpperCaseTextFormatter(),
              ],
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: AppColors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  borderSide: BorderSide(
                    color: _focusNodes[i].hasFocus
                        ? AppColors.primary
                        : AppColors.borderGrey,
                    width: AppSizes.borderWidthLg,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: AppSizes.borderWidthLg,
                  ),
                ),
              ),
              onChanged: (value) {
                final code = _controllers.map((c) => c.text).join();
                widget.onChanged?.call(code);

                if (value.isEmpty) {
                  if (i > 0) _focusNodes[i - 1].requestFocus();
                } else {
                  if (i + 1 < widget.length) {
                    _focusNodes[i + 1].requestFocus();
                  } else {
                    _focusNodes[i].unfocus();
                    if (widget.onCompleted != null &&
                        code.length == widget.length) {
                      widget.onCompleted!(code);
                    }
                  }
                }
                setState(() {});
              },
            ),
          ),
        );
      }),
    );
  }
}

/// TextInputFormatter: otomatik büyük harfe çevirir
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
