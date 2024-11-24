import 'package:flutter/material.dart';
import 'package:legends_schools_admin/config/component/app_text_widget.dart';
import 'package:legends_schools_admin/provider/constant/action_provider.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SearchDropDownWidget<T> extends StatelessWidget {
  final List<T> options;
  final ValueChanged<T?> onChanged;
  final ValueChanged<String>? onSearchChanged;
  final String Function(T) displayText;
  final String placeholderText;
  final String searchPlaceholder;
  final Color backgroundColor;
  final Color borderColor;
  final Color optionTextColor;
  final Color selectedTextColor;
  final double minWidth;
  final double maxWidth;
  final bool enabled;
  final Icon trailingIcon;

  const SearchDropDownWidget({
    super.key,
    required this.options,
    required this.onChanged,
     this.onSearchChanged,
    required this.displayText,
    this.placeholderText = 'Select Option',
    this.searchPlaceholder = 'Search...',
    this.backgroundColor = Colors.blueAccent,
    this.borderColor = Colors.blueAccent,
    this.optionTextColor = Colors.white,
    this.selectedTextColor = Colors.white,
    this.minWidth = 180.0,
    this.maxWidth = 300.0,
    this.enabled = true,
    this.trailingIcon = const Icon(Icons.arrow_circle_down_outlined, color: Colors.white),
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ActionProvider>(
      builder: (context, provider, _) {
        return ShadSelect<T>.withSearch(
          decoration: ShadDecoration(
            color: backgroundColor,
            border: ShadBorder.all(color: borderColor),
          ),
          trailing: trailingIcon,
          enabled: enabled,
          minWidth: minWidth,
          maxWidth: maxWidth,
          placeholder: AppTextWidget(
            text: placeholderText,
            color: Colors.black,
          ),
          onSearchChanged: onSearchChanged ?? (value) {
            provider.updateSearchValue(value);
          },
          searchPlaceholder: Text(searchPlaceholder),
          options: [
            if (options.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text('No options found'),
              ),
            ...options.map(
                  (option) {
                return Offstage(
                  offstage: !options.contains(option),
                  child: ShadOption(
                    hoveredBackgroundColor: backgroundColor,
                    value: option,
                    child: Text(
                      displayText(option),
                      style: TextStyle(color: optionTextColor),
                    ),
                  ),
                );
              },
            ),
          ],
          selectedOptionBuilder: (context, value) {
            return AppTextWidget(
              text: displayText(value),
              color: selectedTextColor,
            );
          },
        );
      },
    );
  }
}
