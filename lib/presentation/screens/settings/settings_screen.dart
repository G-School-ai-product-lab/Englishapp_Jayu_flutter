import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/page_transitions.dart';
import '../../providers/theme_provider.dart';
import '../../providers/auth_provider.dart';
import '../profile/profile_screen.dart';
import '../auth/login_screen.dart';

// Settings providers
final notificationsEnabledProvider = StateProvider<bool>((ref) => true);
final soundEnabledProvider = StateProvider<bool>((ref) => true);
final dailyReminderProvider = StateProvider<bool>((ref) => false);
final autoPlayAudioProvider = StateProvider<bool>((ref) => true);

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    ref.read(notificationsEnabledProvider.notifier).state =
        prefs.getBool('notifications_enabled') ?? true;
    ref.read(soundEnabledProvider.notifier).state =
        prefs.getBool('sound_enabled') ?? true;
    ref.read(dailyReminderProvider.notifier).state =
        prefs.getBool('daily_reminder') ?? false;
    ref.read(autoPlayAudioProvider.notifier).state =
        prefs.getBool('auto_play_audio') ?? true;
  }

  Future<void> _saveSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final authState = ref.watch(authProvider);
    final notificationsEnabled = ref.watch(notificationsEnabledProvider);
    final soundEnabled = ref.watch(soundEnabledProvider);
    final dailyReminder = ref.watch(dailyReminderProvider);
    final autoPlayAudio = ref.watch(autoPlayAudioProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),

          // Account Section
          _buildSectionHeader('계정'),
          Card(
            child: authState.isAuthenticated
                ? Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryLight,
                          child: Text(
                            authState.user!.name[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(authState.user!.name),
                        subtitle: Text(authState.user!.email),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransitions.slideFromRight(const ProfileScreen()),
                          );
                        },
                      ),
                    ],
                  )
                : ListTile(
                    leading: const Icon(Icons.account_circle_outlined),
                    title: const Text('로그인'),
                    subtitle: const Text('계정으로 로그인하기'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransitions.slideFromRight(const LoginScreen()),
                      );
                    },
                  ),
          ),

          const SizedBox(height: 24),

          // Theme Section
          _buildSectionHeader('테마'),
          Card(
            child: Column(
              children: [
                RadioListTile<ThemeMode>(
                  title: const Text('라이트 모드'),
                  subtitle: const Text('밝은 테마 사용'),
                  value: ThemeMode.light,
                  groupValue: themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(themeProvider.notifier).setThemeMode(value);
                    }
                  },
                  activeColor: AppColors.primary,
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('다크 모드'),
                  subtitle: const Text('어두운 테마 사용'),
                  value: ThemeMode.dark,
                  groupValue: themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(themeProvider.notifier).setThemeMode(value);
                    }
                  },
                  activeColor: AppColors.primary,
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('시스템 설정 따라가기'),
                  subtitle: const Text('기기 설정에 따라 자동 전환'),
                  value: ThemeMode.system,
                  groupValue: themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(themeProvider.notifier).setThemeMode(value);
                    }
                  },
                  activeColor: AppColors.primary,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Notifications Section
          _buildSectionHeader('알림'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('알림 활성화'),
                  subtitle: const Text('학습 알림 받기'),
                  value: notificationsEnabled,
                  onChanged: (value) {
                    ref.read(notificationsEnabledProvider.notifier).state = value;
                    _saveSetting('notifications_enabled', value);
                  },
                  activeColor: AppColors.primary,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('일일 학습 리마인더'),
                  subtitle: const Text('매일 학습 시간 알림'),
                  value: dailyReminder,
                  onChanged: notificationsEnabled
                      ? (value) {
                          ref.read(dailyReminderProvider.notifier).state = value;
                          _saveSetting('daily_reminder', value);
                        }
                      : null,
                  activeColor: AppColors.primary,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Learning Settings Section
          _buildSectionHeader('학습 설정'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('소리 효과'),
                  subtitle: const Text('버튼 클릭 및 정답/오답 소리'),
                  value: soundEnabled,
                  onChanged: (value) {
                    ref.read(soundEnabledProvider.notifier).state = value;
                    _saveSetting('sound_enabled', value);
                  },
                  activeColor: AppColors.primary,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('자동 음성 재생'),
                  subtitle: const Text('단어 학습 시 발음 자동 재생'),
                  value: autoPlayAudio,
                  onChanged: (value) {
                    ref.read(autoPlayAudioProvider.notifier).state = value;
                    _saveSetting('auto_play_audio', value);
                  },
                  activeColor: AppColors.primary,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.restore),
                  title: const Text('학습 데이터 초기화'),
                  subtitle: const Text('진행 상황 및 통계 초기화'),
                  onTap: () => _showResetDataDialog(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Data & Privacy Section
          _buildSectionHeader('데이터 및 개인정보'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.cloud_download_outlined),
                  title: const Text('데이터 백업'),
                  subtitle: const Text('학습 데이터 백업하기'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('백업 기능은 준비 중입니다.')),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.cloud_upload_outlined),
                  title: const Text('데이터 복원'),
                  subtitle: const Text('백업된 데이터 복원하기'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('복원 기능은 준비 중입니다.')),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('개인정보 처리방침'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showPrivacyPolicy(context);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // App Info Section
          _buildSectionHeader('앱 정보'),
          Card(
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('버전'),
                  subtitle: Text('1.0.0'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.rate_review_outlined),
                  title: const Text('앱 평가하기'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('스토어로 이동합니다.')),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('도움말'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showHelpDialog(context);
                  },
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.copyright),
                  title: Text('개발자'),
                  subtitle: Text('영어 학습 앱 팀'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  void _showResetDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('학습 데이터 초기화'),
        content: const Text(
          '모든 학습 진행 상황과 통계가 초기화됩니다.\n이 작업은 되돌릴 수 없습니다.\n\n계속하시겠습니까?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('학습 데이터가 초기화되었습니다.')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('초기화'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('개인정보 처리방침'),
        content: const SingleChildScrollView(
          child: Text(
            '본 앱은 사용자의 개인정보를 소중히 여깁니다.\n\n'
            '수집하는 정보:\n'
            '- 이메일 주소\n'
            '- 사용자 이름\n'
            '- 학습 진행 상황\n\n'
            '정보 사용 목적:\n'
            '- 계정 관리\n'
            '- 학습 진행 상황 저장\n'
            '- 서비스 개선\n\n'
            '모든 데이터는 안전하게 암호화되어 저장됩니다.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('도움말'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '사용 방법',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('1. 단어 탭: 단어를 추가하고 암기 상태를 관리합니다.'),
              SizedBox(height: 4),
              Text('2. 문법 탭: 문법 항목을 학습합니다.'),
              SizedBox(height: 4),
              Text('3. 퀴즈 탭: 학습한 내용을 테스트합니다.'),
              SizedBox(height: 4),
              Text('4. 진도 탭: 학습 통계를 확인합니다.'),
              SizedBox(height: 16),
              Text(
                '문의하기',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('이메일: support@englishapp.com'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
