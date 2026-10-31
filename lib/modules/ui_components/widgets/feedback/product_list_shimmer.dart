import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/modules/ui_components/widgets/feedback/ada_shimmer.dart';
import 'package:flutter/material.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AdaShimmer(width: 72, height: 72, borderRadius: 8),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AdaShimmer(height: 16, borderRadius: 4),
                SizedBox(height: 8),
                AdaShimmer(height: 12, borderRadius: 4),
                SizedBox(height: 8),
                AdaShimmer(width: 72, height: 14, borderRadius: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductListShimmer extends StatelessWidget {
  const ProductListShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      itemCount: itemCount,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) => const ProductCardShimmer(),
    );
  }
}
