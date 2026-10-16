import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Поле пошуку з кнопкою очищення, яка з’являється,
/// коли поле не порожнє (stateful-віджет).
class AppSearchField extends StatefulWidget {
  final String hint;
  final ValueChanged<String>? onChanged;

  const AppSearchField({
    super.key,
    this.hint = 'Пошук: «гаманець», «ключі біля ТРЦ»…',
    this.onChanged,
  });

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  final TextEditingController _controller = TextEditingController();
  bool _showClearButton = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() {
      _showClearButton = value.isNotEmpty;
    });
    widget.onChanged?.call(value.trim());
  }

  void _clear() {
    _controller.clear();
    _onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: _controller,
        onChanged: _onChanged,
        textInputAction: TextInputAction.search,
        style: const TextStyle(fontSize: 13.5, color: AppColors.textPrimary),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.surface,
          hintText: widget.hint,
          hintStyle: const TextStyle(
            fontSize: 13.5,
            color: AppColors.textSecondary,
          ),
          contentPadding: EdgeInsets.zero,
          prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          prefixIcon: const Icon(
            Icons.search,
            size: 18,
            color: AppColors.textSecondary,
          ),
          suffixIcon: _showClearButton
              ? IconButton(
                  tooltip: 'Очистити',
                  onPressed: _clear,
                  icon: const Icon(Icons.close, size: 16),
                )
              : const _ShortcutHint(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSmall + 2),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSmall + 2),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
          ),
        ),
      ),
    );
  }
}

class _ShortcutHint extends StatelessWidget {
  const _ShortcutHint();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Center(
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.border),
          ),
          child: const Text(
            'Ctrl K',
            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
        ),
      ),
    );
  }
}
