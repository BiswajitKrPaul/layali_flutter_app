import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';
import 'package:layali_flutter_app/features/profile_information/cubits/profile_image_cubit/profile_image_cubit.dart';

class ImagePickerBottomSheetWidget extends StatelessWidget {
  const ImagePickerBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    context.localizations.editProfilePic,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.router.pop(),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close_sharp, size: 22),
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(context.localizations.takePhoto),
                      trailing: const Icon(Icons.camera_alt),
                      onTap: () async {
                        context.router.pop();
                        await context
                            .read<ProfileImageCubit>()
                            .pickImageFromCamera();
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(context.localizations.choosePhoto),
                      trailing: const Icon(Icons.photo),
                      onTap: () {
                        context.router.pop();
                        context
                            .read<ProfileImageCubit>()
                            .pickImageFromGallery();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
