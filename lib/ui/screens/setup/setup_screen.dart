import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'setup_view_model.dart';
import '../../../data/repository/theme_mode_notifier.dart';
import '../../../services/trivia_notification_service.dart';

class SetupScreen extends ConsumerWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(setupViewModelProvider);
    final notifier = ref.read(setupViewModelProvider.notifier);

    // Navigation listener
    ref.listen(setupViewModelProvider, (previous, next) {
      if (next.isComplete && !(previous?.isComplete ?? false)) {
        // Navigate to landing or home.
        // If back stack is empty (fresh open), go to Landing.
        // Logic from Android: if (prev == null) popUpTo(Setup) inclusive else popBackStack
        // Here we just go to Landing for now.
        context.go('/landing');
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/landing');
            }
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Location Settings Card
            Card(
              elevation: 0,
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location Settings",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Enter your zip code to update federal and state official information automatically.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      onChanged: (value) {
                        if (value.length <= 5) notifier.updateZipCode(value);
                      },
                      controller: TextEditingController(text: state.zipCode)
                        ..selection = TextSelection.fromPosition(
                          TextPosition(offset: state.zipCode.length),
                        ),
                      decoration: InputDecoration(
                        labelText: "Zip Code",
                        hintText: "e.g. 90210",
                        errorText: state.error,
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Trivia Settings Card
            Card(
              elevation: 0,
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Daily Trivia",
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                "Get notified with a random civics question.",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: state.isTriviaEnabled,
                          onChanged: notifier.toggleTrivia,
                        ),
                      ],
                    ),
                    if (state.isTriviaEnabled) ...[
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Frequency",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [1, 60, 240, 480, 720, 1440].map((minutes) {
                          final label = minutes == 1
                              ? "1m (Test)"
                              : "${minutes ~/ 60}h";
                          return ChoiceChip(
                            label: Text(label),
                            selected: state.triviaFrequencyMinutes == minutes,
                            onSelected: (selected) {
                              if (selected) notifier.updateFrequency(minutes);
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Show only unmastered questions"),
                          Switch(
                            value: state.isTriviaFilterUnmastered,
                            onChanged: notifier.toggleTriviaFilter,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Appearance Settings Card
            Card(
              elevation: 0,
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Appearance",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Choose your preferred color theme.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Consumer(
                      builder: (context, ref, _) {
                        final currentMode = ref.watch(themeModeProvider);
                        return Wrap(
                          spacing: 8,
                          children: [
                            for (final entry in [
                              (
                                ThemeMode.light,
                                Icons.light_mode_outlined,
                                'Light',
                              ),
                              (
                                ThemeMode.system,
                                Icons.brightness_auto_outlined,
                                'System',
                              ),
                              (
                                ThemeMode.dark,
                                Icons.dark_mode_outlined,
                                'Dark',
                              ),
                            ])
                              ChoiceChip(
                                avatar: Icon(
                                  entry.$2,
                                  size: 16,
                                  color: currentMode == entry.$1
                                      ? Theme.of(
                                          context,
                                        ).colorScheme.onSecondaryContainer
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                                label: Text(entry.$3),
                                selected: currentMode == entry.$1,
                                onSelected: (selected) {
                                  if (selected) {
                                    notifier.updateThemeMode(entry.$1);
                                  }
                                },
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            FilledButton.icon(
              onPressed: (!state.isLoading && state.zipCode.length == 5)
                  ? notifier.submitSetup
                  : null,
              icon: state.isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.save, size: 18),
              label: Text(state.isLoading ? "Updating..." : "Save Settings"),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),

            const SizedBox(height: 16),

            OutlinedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Reset Progress?"),
                    content: const Text(
                      "This will delete all your study progress and cannot be undone. Are you sure?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          notifier.resetAllProgress();
                          Navigator.of(ctx).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text("Reset"),
                      ),
                    ],
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
              child: const Text("Reset Progress"),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                ref
                    .read(triviaNotificationServiceProvider)
                    .showManualNotification();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Test notification triggered!")),
                );
              },
              icon: const Icon(Icons.notifications_active),
              label: const Text("Send Test Notification"),
            ),
          ],
        ),
      ),
    );
  }
}
