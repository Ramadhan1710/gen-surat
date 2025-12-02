import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';

/// Widget untuk menampilkan progress stepper pada multi-step form
/// Menampilkan step saat ini dan total step dengan visual indicator
class FormStepperProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepTitles;

  const FormStepperProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepTitles,
  }) : assert(currentStep >= 0 && currentStep < totalSteps),
       assert(stepTitles.length == totalSteps);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceM,
        vertical: AppDimensions.spaceM,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProgressBar(colorScheme),
          const SizedBox(height: AppDimensions.spaceS),
          _buildStepIndicator(theme),
        ],
      ),
    );
  }

  Widget _buildProgressBar(ColorScheme colorScheme) {
    final progress = (currentStep + 1) / totalSteps;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Langkah ${currentStep + 1} dari $totalSteps',
              style: AppTextStyles.labelMedium.copyWith(
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: AppTextStyles.labelMedium.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceS),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusCircle),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: AppColors.greyLight,
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildStepIndicator(ThemeData theme) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isCompleted = index < currentStep;
        final isCurrent = index == currentStep;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: _buildStepDot(
                  theme.colorScheme,
                  index,
                  isCompleted,
                  isCurrent,
                ),
              ),
              if (index < totalSteps - 1)
                Expanded(
                  child: Container(
                    height: 2,
                    color:
                        isCompleted
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surfaceContainerHighest,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStepDot(
    ColorScheme colorScheme,
    int index,
    bool isCompleted,
    bool isCurrent,
  ) {
    Color backgroundColor;
    Widget? child;

    if (isCompleted) {
      backgroundColor = colorScheme.primary;
      child = Icon(Icons.check, size: 14, color: colorScheme.onPrimary);
    } else if (isCurrent) {
      backgroundColor = colorScheme.primary;
      child = Text(
        '${index + 1}',
        style: AppTextStyles.labelSmall.copyWith(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      );
    } else {
      backgroundColor = colorScheme.surface;
      child = Text(
        '${index + 1}',
        style: AppTextStyles.labelSmall.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
      );
    }

    return Container(
      width: 24,
      height: 24  ,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
  
      ),
      child: Center(child: child),
    );
  }
}
