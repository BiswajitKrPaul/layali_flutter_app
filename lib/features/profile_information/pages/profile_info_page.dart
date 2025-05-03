import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:layali_flutter_app/common/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:layali_flutter_app/common/utils/constants.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';
import 'package:layali_flutter_app/features/profile_information/cubits/profile_cubit/profile_cubit.dart';
import 'package:layali_flutter_app/features/profile_information/cubits/profile_image_cubit/profile_image_cubit.dart';
import 'package:layali_flutter_app/features/profile_information/widgets/image_picker_bottom_sheet_widget.dart';

final _formKey = GlobalKey<FormState>();

@RoutePage()
class ProfileInfoPage extends StatelessWidget implements AutoRouteWrapper {
  const ProfileInfoPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  ProfileCubit()..setUserData(
                    context.read<AuthenticationCubit>().state.user!,
                  ),
        ),
        BlocProvider(create: (context) => ProfileImageCubit()),
      ],
      child: this,
    );
  }

  InputDecoration _textFormFieldDecoration(String labelText, {Widget? suffix}) {
    return InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    ValidationBuilder.setLocale(context.localizations.localeName);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${context.localizations.edit} ${context.localizations.profile}',
        ),
      ),
      body: Scaffold(
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.longestSide,
              ),
              child: BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state.isDone) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.localizations.profilePicUpdated),
                      ),
                    );
                  } else if (state.hasError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage.isEmpty
                              ? context.localizations.updateFailed
                              : state.errorMessage,
                        ),
                      ),
                    );
                  }
                },
                builder: (context, profileInfoState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      spacing: 24,
                      children: [
                        BlocListener<ProfileImageCubit, ProfileImageState>(
                          listener: (context, state) {
                            if (state.hasError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    context.localizations.noImageSelected,
                                  ),
                                ),
                              );
                            } else if (state.isDone) {
                              context.read<ProfileCubit>().uploadProfileImage(
                                state.imageUrl,
                              );
                            }
                          },
                          child: SizedBox(
                            width: 150,
                            height: 160,
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  width: 150,
                                  height: 150,
                                  imageUrl: profileInfoState.imageUrl,
                                  imageBuilder:
                                      (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                          const CircleAvatar(
                                            radius: 68,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                  Constants.defaultImage,
                                                ),
                                          ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    onPressed: () {
                                      showImagePickerBottomSheet(context);
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      size: 36,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextFormField(
                          initialValue: profileInfoState.firstName,
                          onChanged: context.read<ProfileCubit>().setFirstName,
                          keyboardType: TextInputType.name,
                          decoration: _textFormFieldDecoration(
                            context.localizations.firstName,
                          ),
                          validator:
                              ValidationBuilder()
                                  .maxLength(50)
                                  .required()
                                  .build(),
                        ), // First Name
                        TextFormField(
                          initialValue: profileInfoState.lastName,
                          keyboardType: TextInputType.name,
                          onChanged: context.read<ProfileCubit>().setLastName,
                          decoration: _textFormFieldDecoration(
                            context.localizations.lastName,
                          ),
                          validator:
                              ValidationBuilder()
                                  .maxLength(50)
                                  .required()
                                  .build(),
                        ), // Last Name
                        TextFormField(
                          initialValue: profileInfoState.email,
                          enabled: false,
                          decoration: _textFormFieldDecoration(
                            context.localizations.email,
                          ),
                        ), // Email
                        TextFormField(
                          onChanged:
                              context.read<ProfileCubit>().setPhoneNumber,
                          initialValue: profileInfoState.phoneNumber,
                          keyboardType: TextInputType.phone,
                          decoration: _textFormFieldDecoration(
                            context.localizations.phoneNumber,
                          ),
                          validator:
                              ValidationBuilder().phone().required().build(),
                        ), // Password
                        TextFormField(
                          onChanged:
                              context.read<ProfileCubit>().setEmergencyContact,
                          keyboardType: TextInputType.phone,
                          initialValue: profileInfoState.emergencyContact,
                          decoration: _textFormFieldDecoration(
                            context.localizations.emergencyContact,
                          ),
                          validator:
                              ValidationBuilder().phone().required().build(),
                        ), // Confirm Password
                        TextFormField(
                          onChanged: context.read<ProfileCubit>().setAddress,
                          keyboardType: TextInputType.streetAddress,
                          initialValue: profileInfoState.address,
                          decoration: _textFormFieldDecoration(
                            context.localizations.address,
                          ),
                          validator: ValidationBuilder().required().build(),
                        ),
                        Visibility(
                          visible: profileInfoState.isLoading,
                          child: const CircularProgressIndicator(),
                        ),
                        Visibility(
                          visible: !profileInfoState.isLoading,
                          child: FilledButton(
                            onPressed:
                                profileInfoState.apiPatchBody().isEmpty
                                    ? null
                                    : () async {
                                      if (_formKey.currentState!.validate()) {
                                        await context
                                            .read<ProfileCubit>()
                                            .updateProfile();
                                      }
                                    },
                            child: Text(context.localizations.update),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Widget?> showImagePickerBottomSheet(BuildContext context) {
    final blocVale = context.read<ProfileImageCubit>();
    return showModalBottomSheet<Widget>(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: blocVale,
          child: const ImagePickerBottomSheetWidget(),
        );
      },
    );
  }
}
