import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layali_flutter_app/app_router.gr.dart';
import 'package:layali_flutter_app/common/cubits/app_language_cubit/app_language_cubit.dart';
import 'package:layali_flutter_app/common/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:layali_flutter_app/common/utils/extension_utils.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.profile),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              minVerticalPadding: 0,
              onTap: () {},
              title: Text(
                context.read<AuthenticationCubit>().state.user!.firstName,
              ),
              subtitle: Text(
                context.read<AuthenticationCubit>().state.user!.email,
              ),
              leading: const SizedBox(
                width: 48,
                child: CircleAvatar(radius: 100),
              ),
            ),

            // Account settings section
            _buildSection(
              title: context.localizations.accountSettings,
              content: Column(
                children: [
                  _buildListTile(
                    context.localizations.personalInformation,
                    Icons.chevron_right,
                    onTap:
                        () => context.router.push(const ProfileInfoPageRoute()),
                  ),
                ],
              ),
            ),

            // Housing section
            _buildSection(
              title: context.localizations.housing,
              content: Column(
                children: [
                  _buildListTile(
                    context.localizations.listYourSpace,
                    Icons.chevron_right,
                  ),
                  _buildListTile(
                    context.localizations.paymentsAndPayouts,
                    Icons.chevron_right,
                  ),
                ],
              ),
            ),

            // Tools section
            _buildSection(
              title: context.localizations.tools,
              content: Column(
                children: [
                  _buildListTile(
                    context.localizations.termAndService,
                    Icons.chevron_right,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(context.localizations.logout),
                    trailing: const Icon(Icons.lock_person_outlined, size: 18),
                    onTap: () {
                      context.read<AuthenticationCubit>().logout();
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<AppLanguageCubit, AppLanguageState>(
              builder: (context, state) {
                return DropdownButton<String>(
                  value: state.index,
                  elevation: 16,
                  onChanged: (String? value) {
                    context.read<AppLanguageCubit>().changeLanguage(value!);
                  },
                  items:
                      state.supportedLocales
                          .mapIndexed<DropdownMenuItem<String>>((i, e) {
                            return DropdownMenuItem(
                              value: e.languageCode,
                              child: Text(e.languageCode),
                            );
                          })
                          .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, Widget? content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          content ?? const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildListTile(
    String title,
    IconData trailingIcon, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: Icon(trailingIcon),
      onTap: onTap,
    );
  }
}
