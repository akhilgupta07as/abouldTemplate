import 'dart:async';

import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/core/routing/route_names.dart';
import 'package:abould_ada/core/theme/app_colors.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/authentication/presentation/widgets/auth_page_shell.dart';
import 'package:abould_ada/modules/authentication/presentation/widgets/otp_input_row.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({
    super.key,
    this.email,
    this.flow = 'signup',
  });

  final String? email;
  final String flow;

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  String _code = '';
  bool _loading = false;
  int _secondsLeft = 45;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = 45);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 1) {
        t.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  Future<void> _verify() async {
    if (_code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.otpCodeRequired)),
      );
      return;
    }

    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _loading = false);

    if (widget.flow == 'reset') {
      final query = widget.email != null
          ? '?email=${Uri.encodeComponent(widget.email!)}'
          : '';
      context.push('${RouteNames.resetPassword}$query');
      return;
    }

    context.go(RouteNames.login);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.otpVerifiedSuccess)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final email = widget.email ?? 'your email';

    return AuthPageShell(
      title: context.l10n.verifyOtpTitle,
      subtitle: context.l10n.otpSentTo(email),
      child: AdaCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.sms_outlined, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      context.l10n.otpDemoHint,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            OtpInputRow(onCompleted: (code) => setState(() => _code = code)),
            const SizedBox(height: AppSpacing.lg),
            AdaLoadingButton(
              label: context.l10n.verifyButton,
              icon: Icons.verified_user_outlined,
              isLoading: _loading,
              onPressed: _verify,
            ),
            const SizedBox(height: AppSpacing.md),
            Center(
              child: _secondsLeft > 0
                  ? Text(
                      context.l10n.resendCodeIn(_secondsLeft),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    )
                  : TextButton(
                      onPressed: _startTimer,
                      child: Text(context.l10n.resendCode),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
