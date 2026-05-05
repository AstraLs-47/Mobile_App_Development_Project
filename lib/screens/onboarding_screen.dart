import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';


class OnboardingData {
  String? goal;
  String? activityLevel;
  String sex = 'Female';
  DateTime? dateOfBirth;
  double? height;
  double? currentWeight;
  double? goalWeight;
}


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final OnboardingData _data = OnboardingData();

  final List<String> goals = [
    'Lose Weight',
    'Gain Weight',
    'Gain Muscle',
    'Manage Stress',
    'Maintain Weight',
  ];

  final List<String> activityLevels = [
    'Active',
    'Very Active',
    'Lightly Active',
    'Not Very Active',
  ];

  void _nextPage() {
    if (_currentPage < 2) {
      setState(() => _currentPage++);
    } else {
      _finishOnboarding();
    }
  }

  void _prevPage() {
    if (_currentPage > 0) setState(() => _currentPage--);
  }

  void _finishOnboarding() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Onboarding complete! Welcome to PurePulse.')),
    );
  }

  bool get _canProceed {
    switch (_currentPage) {
      case 0:
        return _data.goal != null;
      case 1:
        return _data.activityLevel != null;
      case 2:
        return _data.dateOfBirth != null &&
            _data.height != null &&
            _data.currentWeight != null &&
            _data.goalWeight != null;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          transitionBuilder: (child, animation) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.12, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
                parent: animation, curve: Curves.easeOut)),
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: _buildPage(_currentPage),
        ),
      ),
    );
  }

  Widget _buildPage(int page) {
    switch (page) {
      case 0:
        return _GoalPage(
          key: const ValueKey('q1'),
          goals: goals,
          selected: _data.goal,
          onSelect: (g) => setState(() => _data.goal = g),
          onNext: _canProceed ? _nextPage : null,
        );
      case 1:
        return _ActivityPage(
          key: const ValueKey('q2'),
          levels: activityLevels,
          selected: _data.activityLevel,
          onSelect: (a) => setState(() => _data.activityLevel = a),
          onNext: _canProceed ? _nextPage : null,
          onBack: _prevPage,
        );
      case 2:
        return _PhysicalInfoPage(
          key: const ValueKey('q3'),
          data: _data,
          canProceed: _canProceed,
          onChanged: () => setState(() {}),
          onNext: _canProceed ? _nextPage : null,
          onBack: _prevPage,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}


class _Header extends StatelessWidget {
  final String title;
  final String subtitle;
  const _Header({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'THE PULSE',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}


class _SelectableOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectableOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.06)
              : AppColors.surface,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primary : AppColors.textPrimary,
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}


class _NavButtons extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onNext;

  const _NavButtons({
    this.onBack,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (onBack != null) ...[
          Expanded(
            child: SizedBox(
              height: 48,
              child: OutlinedButton(
                onPressed: onBack,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundColor: AppColors.primary,
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor:
                    AppColors.primary.withValues(alpha: 0.4),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Q1:Goal

class _GoalPage extends StatelessWidget {
  final List<String> goals;
  final String? selected;
  final ValueChanged<String> onSelect;
  final VoidCallback? onNext;

  const _GoalPage({
    super.key,
    required this.goals,
    required this.selected,
    required this.onSelect,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Header(
            title: 'Hey, User 💪',
            subtitle: 'What is your goal?',
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: goals
                    .map(
                      (g) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _SelectableOption(
                          label: g,
                          isSelected: selected == g,
                          onTap: () => onSelect(g),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _NavButtons(onNext: onNext),
        ],
      ),
    );
  }
}

//Q2:Activity Level

class _ActivityPage extends StatelessWidget {
  final List<String> levels;
  final String? selected;
  final ValueChanged<String> onSelect;
  final VoidCallback? onNext;
  final VoidCallback onBack;

  const _ActivityPage({
    super.key,
    required this.levels,
    required this.selected,
    required this.onSelect,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Header(
            title: 'Hey, User 💪',
            subtitle: 'What is your baseline activity level?',
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: levels
                    .map(
                      (l) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _SelectableOption(
                          label: l,
                          isSelected: selected == l,
                          onTap: () => onSelect(l),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _NavButtons(onBack: onBack, onNext: onNext),
        ],
      ),
    );
  }
}

//Q3:Physical Info

class _PhysicalInfoPage extends StatefulWidget {
  final OnboardingData data;
  final bool canProceed;
  final VoidCallback onChanged;
  final VoidCallback? onNext;
  final VoidCallback onBack;

  const _PhysicalInfoPage({
    super.key,
    required this.data,
    required this.canProceed,
    required this.onChanged,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<_PhysicalInfoPage> createState() => _PhysicalInfoPageState();
}

class _PhysicalInfoPageState extends State<_PhysicalInfoPage> {
  late final TextEditingController _dobController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final TextEditingController _goalWeightController;

  @override
  void initState() {
    super.initState();
    _dobController = TextEditingController(
      text: widget.data.dateOfBirth != null
          ? '${widget.data.dateOfBirth!.month.toString().padLeft(2, '0')}/'
              '${widget.data.dateOfBirth!.day.toString().padLeft(2, '0')}/'
              '${widget.data.dateOfBirth!.year}'
          : '',
    );
    _heightController =
        TextEditingController(text: widget.data.height?.toString() ?? '');
    _weightController =
        TextEditingController(text: widget.data.currentWeight?.toString() ?? '');
    _goalWeightController =
        TextEditingController(text: widget.data.goalWeight?.toString() ?? '');
  }

  @override
  void dispose() {
    _dobController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _goalWeightController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.data.dateOfBirth ??
          DateTime(now.year - 25, now.month, now.day),
      firstDate: DateTime(1920),
      lastDate: DateTime(now.year - 10),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme:
              const ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      widget.data.dateOfBirth = picked;
      _dobController.text =
          '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
      widget.onChanged();
    }
  }

  InputDecoration _fieldDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: const TextStyle(
            color: AppColors.textSecondary, fontSize: 14),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      );

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Header(
            title: 'Hey, User 💪',
            subtitle:
                'Please select which sex we should use to\ncalculate your calorie needs.',
          ),
          const SizedBox(height: 20),

          // Sex toggle
          Row(
            children: ['Female', 'Male'].map((sex) {
              final isSelected = widget.data.sex == sex;
              return Padding(
                padding: const EdgeInsets.only(right: 24),
                child: GestureDetector(
                  onTap: () {
                    widget.data.sex = sex;
                    widget.onChanged();
                  },
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            width: isSelected ? 2 : 1.5,
                          ),
                          color: isSelected
                              ? AppColors.primary
                              : Colors.transparent,
                        ),
                        child: isSelected
                            ? const Icon(Icons.check,
                                color: Colors.white, size: 12)
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        sex,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Date of birth
          _label('When were you born?'),
          GestureDetector(
            onTap: _pickDate,
            child: AbsorbPointer(
              child: TextField(
                controller: _dobController,
                decoration: _fieldDecoration('mm/dd/yyyy'),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Height
          _label('How tall are you?'),
          TextField(
            controller: _heightController,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d{0,2}'))
            ],
            decoration: _fieldDecoration('Height (meter)'),
            onChanged: (v) {
              widget.data.height = double.tryParse(v);
              widget.onChanged();
            },
          ),
          const SizedBox(height: 16),

          // Current weight
          _label('How much do you weigh?'),
          TextField(
            controller: _weightController,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d{0,1}'))
            ],
            decoration: _fieldDecoration('Current weight (kg)'),
            onChanged: (v) {
              widget.data.currentWeight = double.tryParse(v);
              widget.onChanged();
            },
          ),
          const SizedBox(height: 16),

          // Goal weight
          _label("What's your goal weight?"),
          TextField(
            controller: _goalWeightController,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d{0,1}'))
            ],
            decoration: _fieldDecoration('Goal weight (kg)'),
            onChanged: (v) {
              widget.data.goalWeight = double.tryParse(v);
              widget.onChanged();
            },
          ),
          const SizedBox(height: 28),

          _NavButtons(
            onBack: widget.onBack,
            onNext: widget.onNext,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}