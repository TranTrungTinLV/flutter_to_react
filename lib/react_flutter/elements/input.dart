import 'package:flutter/material.dart';
import '../style.dart';

enum InputType { text, email, password, number, tel, search, textarea }

/// Equivalent to HTML <input> and <textarea>
class Input extends StatefulWidget {
  final InputType type;
  final String? placeholder;
  final String? value;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSubmit;
  final VoidCallback? onBlur;
  final Style? style;
  final int? maxLength;
  final int? maxLines;
  final bool disabled;
  final bool autoFocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? label;
  final String? error;
  final TextInputAction? textInputAction;

  const Input({
    super.key,
    this.type = InputType.text,
    this.placeholder,
    this.value,
    this.onChange,
    this.onSubmit,
    this.onBlur,
    this.style,
    this.maxLength,
    this.maxLines,
    this.disabled = false,
    this.autoFocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.error,
    this.textInputAction,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late TextEditingController _controller;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
  }

  @override
  void didUpdateWidget(Input old) {
    super.didUpdateWidget(old);
    if (widget.value != null && widget.value != _controller.text) {
      _controller.text = widget.value!;
      _controller.selection = TextSelection.collapsed(
        offset: _controller.text.length,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextInputType get _keyboardType {
    switch (widget.type) {
      case InputType.email:
        return TextInputType.emailAddress;
      case InputType.password:
        return TextInputType.visiblePassword;
      case InputType.number:
        return TextInputType.number;
      case InputType.tel:
        return TextInputType.phone;
      case InputType.search:
        return TextInputType.text;
      case InputType.textarea:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.style;
    final isPassword = widget.type == InputType.password;
    final isTextarea = widget.type == InputType.textarea;

    final border = OutlineInputBorder(
      borderRadius: s?.borderRadiusValue ?? BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Style.parseColor(s?.borderColor ?? '#d0d0d0')!,
        width: s?.borderWidth ?? 1.0,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: s?.borderRadiusValue ?? BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 2.0,
      ),
    );

    Widget? suffixWidget = widget.suffixIcon;
    if (isPassword) {
      suffixWidget = IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_off : Icons.visibility,
          size: 20,
          color: Colors.grey,
        ),
        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
      );
    }

    return TextFormField(
      controller: _controller,
      obscureText: isPassword && _obscurePassword,
      keyboardType: _keyboardType,
      enabled: !widget.disabled,
      autofocus: widget.autoFocus,
      maxLength: widget.maxLength,
      maxLines: isTextarea ? (widget.maxLines ?? 4) : 1,
      textInputAction: widget.textInputAction ??
          (isTextarea ? TextInputAction.newline : TextInputAction.done),
      onChanged: widget.onChange,
      onFieldSubmitted: widget.onSubmit,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
        widget.onBlur?.call();
      },
      style: s?.textStyle,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        labelText: widget.label,
        errorText: widget.error,
        prefixIcon: widget.prefixIcon,
        suffixIcon: suffixWidget,
        filled: Style.parseColor(s?.backgroundColor) != null,
        fillColor: Style.parseColor(s?.backgroundColor),
        contentPadding: s?.edgePadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: border,
        enabledBorder: border,
        focusedBorder: focusedBorder,
        errorBorder: OutlineInputBorder(
          borderRadius: s?.borderRadiusValue ?? BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: s?.borderRadiusValue ?? BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}

/// Equivalent to HTML <select> / <option>
class Select<T> extends StatelessWidget {
  final T? value;
  final List<SelectOption<T>> options;
  final ValueChanged<T?>? onChange;
  final String? placeholder;
  final Style? style;

  const Select({
    super.key,
    this.value,
    required this.options,
    this.onChange,
    this.placeholder,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final s = style;
    return DropdownButtonFormField<T>(
      initialValue: value,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: placeholder,
        border: OutlineInputBorder(
          borderRadius: s?.borderRadiusValue ?? BorderRadius.circular(8),
        ),
        contentPadding: s?.edgePadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      items: options
          .map(
            (o) => DropdownMenuItem<T>(
              value: o.value,
              child: Text(o.label),
            ),
          )
          .toList(),
    );
  }
}

class SelectOption<T> {
  final T value;
  final String label;
  const SelectOption({required this.value, required this.label});
}
