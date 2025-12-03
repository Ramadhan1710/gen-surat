import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/widgets/loading_progress_widget.dart';

class FormNavigationButton extends StatelessWidget {
  final bool isLoading;
  final double uploadProgress;

  final bool hasGeneratedFile;
  final Widget? generatedFileWidget;

  final bool canGoPrevious;
  final bool canGoNext;
  final bool isLastStep;

  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onGenerate;
  final VoidCallback onCancelLoading;
  final VoidCallback onDone;

  const FormNavigationButton({
    super.key,
    required this.isLoading,
    required this.uploadProgress,
    required this.hasGeneratedFile,
    this.generatedFileWidget,
    required this.canGoPrevious,
    required this.canGoNext,
    required this.isLastStep,
    required this.onPrevious,
    required this.onNext,
    required this.onGenerate,
    required this.onCancelLoading,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {


    if (isLoading) {
      return LoadingProgressWidget(
        progress: uploadProgress,
        onCancel: onCancelLoading,
      );
    }

    // Jika file sudah dibuat
    if (hasGeneratedFile) {
      return Column(
        children: [
          if (generatedFileWidget != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spaceM),
              child: generatedFileWidget!,
            ),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: onDone,
              icon: const Icon(Icons.check_circle_rounded, size: 20),
              label: Text(
                'Selesai',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ),
        ],
      );
    }
    // Default navigation
    return Row(
      children: [
        // Tombol sebelumnya
        if (canGoPrevious)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onPrevious,
              icon: const Icon(Icons.arrow_back),
              label: Text(
                'Sebelumnya',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ),

        if ((canGoPrevious && canGoNext) || isLastStep)
          const SizedBox(width: AppDimensions.spaceM),

        // Tombol next atau generate
        Expanded(
          flex: canGoPrevious ? 1 : 2,
          child:
              isLastStep
                  ? FilledButton(
                    onPressed: onGenerate,
                     style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Generate Surat',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  )
                  : FilledButton.icon(
                    onPressed: onNext,
                    icon: const Icon(Icons.arrow_forward),
                    label: Text(
                      'Selanjutnya',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
        ),
      ],
    );
  }
}
