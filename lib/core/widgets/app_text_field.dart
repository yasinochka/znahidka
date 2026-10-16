import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Стилізоване текстове поле введення з підписом.
/// Для паролів зберігає стан видимості (кнопка «око»).
class AppTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final bool isPassword;
  final String? errorText;
  final String? helperText;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.isPassword = false,
    this.errorText,
    this.helperText,
    this.initialValue,
    this.controller,
    this.keyboardType,
    this.onChanged,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController _controller;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  OutlineInputBorder _border(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSmall + 2),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _controller,
          obscureText: widget.isPassword && _obscureText,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          cursorColor: AppColors.primary,
          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: AppColors.surface,
            hintText: widget.hint,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            helperText: widget.helperText,
            helperStyle: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            errorText: widget.errorText,
            errorStyle: const TextStyle(fontSize: 12, color: AppColors.error),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            prefixIcon: widget.prefixIcon == null
                ? null
                : Icon(widget.prefixIcon,
                    size: 18, color: AppColors.textSecondary),
            suffixIcon: widget.isPassword
                ? IconButton(
                    tooltip: _obscureText ? 'Показати пароль' : 'Сховати пароль',
                    onPressed: _toggleVisibility,
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                  )
                : null,
            enabledBorder: _border(AppColors.border),
            focusedBorder: _border(AppColors.primary, 1.6),
            errorBorder: _border(AppColors.error),
            focusedErrorBorder: _border(AppColors.error, 1.6),
          ),
        ),
      ],
    );
  }
}
