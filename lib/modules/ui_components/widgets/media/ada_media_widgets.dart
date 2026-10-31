import 'dart:io';

import 'package:abould_ada/core/theme/app_radius.dart';
import 'package:abould_ada/core/theme/app_spacing.dart';
import 'package:abould_ada/modules/ui_components/widgets/ada_card.dart';
import 'package:abould_ada/modules/ui_components/widgets/buttons/ada_buttons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdaImagePickerButton extends StatelessWidget {
  const AdaImagePickerButton({
    super.key,
    required this.label,
    required this.onImagePicked,
    this.source = ImageSource.gallery,
  });

  final String label;
  final ValueChanged<XFile> onImagePicked;
  final ImageSource source;

  @override
  Widget build(BuildContext context) {
    return AdaOutlinedButton(
      label: label,
      icon: Icons.image_outlined,
      onPressed: () async {
        final file = await ImagePicker().pickImage(source: source);
        if (file != null) onImagePicked(file);
      },
    );
  }
}

class AdaImagePreview extends StatelessWidget {
  const AdaImagePreview({
    super.key,
    required this.file,
    this.height = 160,
    this.onClear,
  });

  final XFile file;
  final double height;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Image.file(
            File(file.path),
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        if (onClear != null)
          Positioned(
            top: 8,
            right: 8,
            child: IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: Colors.black54,
                foregroundColor: Colors.white,
              ),
              onPressed: onClear,
              icon: const Icon(Icons.close, size: 18),
            ),
          ),
      ],
    );
  }
}

class AdaImageGallery extends StatelessWidget {
  const AdaImageGallery({
    super.key,
    required this.files,
    this.itemSize = 88,
    this.onTap,
  });

  final List<XFile> files;
  final double itemSize;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    if (files.isEmpty) {
      return Text(
        'No images',
        style: Theme.of(context).textTheme.bodySmall,
      );
    }
    return SizedBox(
      height: itemSize,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: files.length,
        separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: onTap != null ? () => onTap!(index) : null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Image.file(
                File(files[index].path),
                width: itemSize,
                height: itemSize,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class AdaFileUpload extends StatelessWidget {
  const AdaFileUpload({
    super.key,
    required this.onFilePicked,
    this.label = 'Upload file',
  });

  final ValueChanged<PlatformFile> onFilePicked;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AdaOutlinedButton(
      label: label,
      icon: Icons.upload_file_outlined,
      onPressed: () async {
        final result = await FilePicker.platform.pickFiles();
        final file = result?.files.single;
        if (file != null) onFilePicked(file);
      },
    );
  }
}

class AdaDocumentPreview extends StatelessWidget {
  const AdaDocumentPreview({
    super.key,
    required this.fileName,
    this.subtitle,
    this.onRemove,
  });

  final String fileName;
  final String? subtitle;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return AdaCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(
              Icons.description_outlined,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          ),
          if (onRemove != null)
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.close),
            ),
        ],
      ),
    );
  }
}

class AdaVideoPreviewPlaceholder extends StatelessWidget {
  const AdaVideoPreviewPlaceholder({
    super.key,
    this.title = 'Video preview',
    this.durationLabel,
    this.onPlay,
  });

  final String title;
  final String? durationLabel;
  final VoidCallback? onPlay;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AdaCard(
      padding: EdgeInsets.zero,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton.filled(
                  onPressed: onPlay,
                  iconSize: 36,
                  icon: const Icon(Icons.play_arrow_rounded),
                ),
                const SizedBox(height: 8),
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                if (durationLabel != null)
                  Text(durationLabel!, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
