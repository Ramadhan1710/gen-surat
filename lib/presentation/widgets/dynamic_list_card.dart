import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';

class DynamicListCard extends StatelessWidget {
  final String title;
  final VoidCallback onRemove;
  final Widget child;

  const DynamicListCard({
    super.key,
    required this.title,
    required this.onRemove,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                // IconButton(
                //   icon: const Icon(Icons.delete_outline),
                //   color: Theme.of(context).colorScheme.error,
                //   onPressed: onRemove,
                //   tooltip: 'Hapus',
                // ),
              ],
            ),
            const Divider(),
            const SizedBox(height: AppDimensions.spaceS),
            child,
          ],
        ),
      ),
    );
  }
}
