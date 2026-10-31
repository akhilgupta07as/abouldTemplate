import 'package:abould_ada/core/di/common_services_providers.dart';
import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/core/localization/l10n_extensions.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/modules/authentication/presentation/utils/auth_messages.dart';
import 'package:abould_ada/modules/firebase/constants/firestore_paths.dart';
import 'package:abould_ada/modules/firebase/di/firebase_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatarUpload extends ConsumerStatefulWidget {
  const ProfileAvatarUpload({super.key, this.radius = 44});

  final double radius;

  @override
  ConsumerState<ProfileAvatarUpload> createState() =>
      _ProfileAvatarUploadState();
}

class _ProfileAvatarUploadState extends ConsumerState<ProfileAvatarUpload> {
  bool _uploading = false;
  String? _avatarUrl;

  Future<void> _pickAndUpload() async {
    final l10n = context.l10n;
    final config = ref.read(appConfigProvider);
    final user = ref.read(currentAuthUserProvider);
    if (user == null) {
      AuthMessages.showError(context, l10n.avatarUploadSignIn);
      return;
    }
    if (!config.useFirebase) {
      AuthMessages.showError(context, l10n.avatarUploadFirebaseOff);
      return;
    }

    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    setState(() => _uploading = true);
    try {
      final compressed = await ref
          .read(imageCompressionServiceProvider)
          .compressForUpload(picked.path);
      final uploadPath = compressed?.path ?? picked.path;

      final storage = ref.read(firebaseStorageServiceProvider);
      final path = FirestorePaths.userAvatarStorage(user.id);
      final url = await storage.uploadFile(
        storagePath: path,
        localFilePath: uploadPath,
        contentType: 'image/jpeg',
      );

      await ref.read(firestoreServiceProvider).setDocument(
        FirestorePaths.userProfile(user.id),
        {
          'avatarUrl': url,
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );

      if (mounted) {
        setState(() => _avatarUrl = url);
        AuthMessages.showSuccess(context, l10n.avatarUploadSuccess);
      }
    } catch (e) {
      if (mounted) {
        AuthMessages.showError(context, l10n.avatarUploadFailed(e.toString()));
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: widget.radius,
          backgroundImage:
              _avatarUrl != null ? NetworkImage(_avatarUrl!) : null,
          child: _avatarUrl == null
              ? Icon(Icons.person, size: widget.radius)
              : null,
        ),
        if (_uploading)
          Positioned.fill(
            child: CircleAvatar(
              radius: widget.radius,
              backgroundColor: Colors.black45,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        Material(
          color: Theme.of(context).colorScheme.primary,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: _uploading ? null : _pickAndUpload,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(
                Icons.camera_alt_rounded,
                size: widget.radius * 0.35,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
