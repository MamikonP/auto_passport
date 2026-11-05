import 'package:flutter/material.dart';
import '../../../core/enums/currency.dart';
import '../../../core/theme/app_colors.dart';

class SettingsCurrencySelector extends StatelessWidget {
  final Currency selectedCurrency;
  final ValueChanged<Currency> onSelected;

  const SettingsCurrencySelector({
    super.key,
    required this.selectedCurrency,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: Currency.values.map((curr) {
        final isSelected = selectedCurrency == curr;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: GestureDetector(
              onTap: () => onSelected(curr),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 11),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.darkSurfaceVariant,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryLight : AppColors.darkBorder,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${curr.symbol} ${curr.code}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
