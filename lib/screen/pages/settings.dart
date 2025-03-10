import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  @override
  Widget build(BuildContext context) {
    final _controller = ValueNotifier<bool>(ref.watch(displayProvider).isLightMode);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LogaText(
                content: "Display Mode",
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
              ),
              AdvancedSwitch(
                controller: _controller,
                activeColor: Theme.of(context).colorScheme.onSurface,
                inactiveColor: Theme.of(context).colorScheme.onSurface,
                borderRadius: BorderRadius.all(const Radius.circular(15)),
                width: 80,
                height: 40.0,
                enabled: true,
                disabledOpacity: 0.5,
                onChanged: (value) {
                  ref.read(displayProvider.notifier).changeDisplayState(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
