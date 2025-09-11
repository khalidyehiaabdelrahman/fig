import 'package:easy_localization/easy_localization.dart';
import 'package:fig/core/widgets/custom_button.dart';
import 'package:fig/features/home/widgets/snack_bar_widget.dart';
import 'package:fig/features/profile/presentation/cubit/profile_state.dart';
import 'package:fig/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fig/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/core/utils/responsive.dart';

class UserProfilePage extends StatefulWidget {
  final SharedUserData? userData;

  const UserProfilePage({super.key, this.userData});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  SharedUserData? _userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (widget.userData != null) {
      setState(() {
        _userData = widget.userData;
      });
    } else {
      final profileCubit = context.read<ProfileCubit>();
      final storedData = await profileCubit.getStoredUserData();
      setState(() {
        _userData = storedData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_userData == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('user_profile'.tr()),
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('user_profile'.tr()),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.rw(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.rw(context)),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.red.shade100,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.red.shade700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${_userData!.firstName ?? ''} ${_userData!.lastName ?? ''}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _userData!.email ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                
                Text(
                  'personal_information'.tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                
                _buildInfoCard(
                  title: 'full_name'.tr(),
                  value:
                      '${_userData!.firstName ?? ''} ${_userData!.lastName ?? ''}',
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 12),

                _buildInfoCard(
                  title: 'email'.tr(),
                  value: _userData!.email ?? '',
                  icon: Icons.email_outlined,
                ),

                const SizedBox(height: 12),

                
                _buildInfoCard(
                  title: 'phone'.tr(),
                  value: _userData!.phone?.toString() ?? 'No phone',
                  icon: Icons.phone_outlined,
                ),

                const SizedBox(height: 32),

                PrimaryButton(
                  label: 'logout'.tr(),
                  onPressed: () async {
                    
                    await context.read<ProfileCubit>().logout();

                    
                    TopSnackBar.show(
                      context,
                      message: "logout_success".tr(),
                      icon: Icons.exit_to_app,
                      backgroundColor: Colors.blueGrey,
                    );

                    
                    if (!mounted) return;

                    
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const ProfilePage()),
                      (route) => false,
                    );
                  },
                  backgroundColor: Colors.red.shade700,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red.shade700, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
