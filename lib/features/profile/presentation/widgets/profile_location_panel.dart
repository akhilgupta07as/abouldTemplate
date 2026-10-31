import 'package:abould_ada/core/di/common_services_providers.dart';
import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileLocationPanel extends ConsumerStatefulWidget {
  const ProfileLocationPanel({super.key});

  @override
  ConsumerState<ProfileLocationPanel> createState() =>
      _ProfileLocationPanelState();
}

class _ProfileLocationPanelState extends ConsumerState<ProfileLocationPanel> {
  bool _loading = false;
  double? _lat;
  double? _lng;
  String? _error;

  Future<void> _refresh() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final result =
        await ref.read(locationServiceProvider).getCurrentPosition();
    if (!mounted) return;
    setState(() {
      _loading = false;
      if (result.permissionDenied) {
        _error = context.l10n.locationPermissionDenied;
      } else if (result.errorMessage != null) {
        _error = context.l10n.locationFetchFailed;
      } else {
        _lat = result.position?.latitude;
        _lng = result.position?.longitude;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.l10n.locationTitle,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (_lat != null && _lng != null) ...[
            Text('${context.l10n.locationLatitude}: $_lat'),
            Text('${context.l10n.locationLongitude}: $_lng'),
          ] else if (_error != null)
            Text(_error!, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppSpacing.md),
          FilledButton.tonal(
            onPressed: _loading ? null : _refresh,
            child: _loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(context.l10n.locationRefresh),
          ),
        ],
      ),
    );
  }
}
