import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_text_theme.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/constants/app_breakpoints.dart';
import '../../domain/auth_provider.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/auth_form.dart';
import '../widgets/auth_stage.dart';

/// Jornada de entrada: splash da marca e, em seguida, o formulário.
class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView>
    with TickerProviderStateMixin {
  static const _splash = Duration(milliseconds: 1300);
  static const _fade = Duration(milliseconds: 400);
  static const _word = AuthBrandMark.text;

  late final AnimationController _entrance;
  late final AnimationController _flight;
  final GlobalKey _stackKey = GlobalKey();
  final GlobalKey _lettersKey = GlobalKey();
  final GlobalKey _brandSlotKey = GlobalKey();
  Timer? _enterShell;
  Rect? _from;
  Rect? _to;
  var _flightQueued = false;
  var _measureAttempts = 0;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(vsync: this, duration: _splash)..forward();
    _flight = AnimationController(vsync: this, duration: _fade);
  }

  @override
  void dispose() {
    _enterShell?.cancel();
    _entrance.dispose();
    _flight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(authViewModelProvider);
    final notifier = ref.read(authViewModelProvider.notifier);
    final dark = AppTheme.dark(createTextTheme(context, 'Inter', 'Inter'));

    ref.listen(authViewModelProvider, (previous, next) {
      final accepted = next.statusCode == 200 || next.statusCode == 201;
      final wasAccepted =
          previous?.statusCode == 200 || previous?.statusCode == 201;

      if (!accepted) {
        _enterShell?.cancel();
        return;
      }

      if (wasAccepted) {
        return;
      }

      _enterShell?.cancel();
      _enterShell = Timer(const Duration(milliseconds: 500), () {
        if (!mounted) {
          return;
        }

        ref.read(authViewModelProvider.notifier).commitSession();
      });
    });

    return Theme(
      data: dark,
      child: Scaffold(
        backgroundColor: dark.colorScheme.surface,
        body: AnimatedBuilder(
          animation: Listenable.merge([_entrance, _flight]),
          builder: (context, _) {
            _queueFlight();
            final reveal = Curves.easeOutCubic.transform(_flight.value);
            final showBrand = _flight.isCompleted;
            final flying = _from != null && _to != null && !showBrand;

            return Stack(
              key: _stackKey,
              fit: StackFit.expand,
              children: [
                if (_entrance.isCompleted)
                  IgnorePointer(
                    ignoring: !showBrand,
                    child: Opacity(
                      opacity: reveal,
                      child: _AuthLayout(
                        form: form,
                        onIntent: notifier.setIntent,
                        onEmail: notifier.setEmail,
                        onPassword: notifier.setPassword,
                        onPasswordUnfocused: notifier.unfocusPassword,
                        onSubmit: notifier.submit,
                        onSocial: notifier.signInWithSocial,
                        brandSlotKey: _brandSlotKey,
                        showBrand: showBrand,
                      ),
                    ),
                  ),
                if (!showBrand && flying)
                  Positioned(
                    left: _from!.left + (_to!.left - _from!.left) * reveal,
                    top: _from!.top + (_to!.top - _from!.top) * reveal,
                    child: AuthBrandMark(key: _lettersKey),
                  )
                else if (!showBrand)
                  Center(child: _writingMark()),
              ],
            );
          },
        ),
      ),
    );
  }

  double get _elapsedMs => _entrance.value * _splash.inMilliseconds;

  double get _splashT {
    final t = (_elapsedMs / _splash.inMilliseconds).clamp(0.0, 1.0);

    return Curves.easeOutCubic.transform(t);
  }

  void _queueFlight() {
    if (!_entrance.isCompleted || _flightQueued || _flight.isAnimating) {
      return;
    }

    _flightQueued = true;
    _measureAndFly();
  }

  void _measureAndFly() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _flight.isAnimating || _flight.isCompleted) {
        return;
      }

      final from = _rectInStack(_lettersKey);
      final to = _rectInStack(_brandSlotKey);

      if (from == null || to == null) {
        _measureAttempts++;
        if (_measureAttempts < 8) {
          _measureAndFly();
          return;
        }

        _flight.value = 1;
        return;
      }

      setState(() {
        _from = from;
        _to = to;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_flight.isAnimating && !_flight.isCompleted) {
          _flight.forward();
        }
      });
    });
  }

  Rect? _rectInStack(GlobalKey key) {
    final target = key.currentContext?.findRenderObject() as RenderBox?;
    final stack = _stackKey.currentContext?.findRenderObject() as RenderBox?;

    if (target == null ||
        stack == null ||
        !target.hasSize ||
        !target.attached ||
        !stack.hasSize ||
        !stack.attached) {
      return null;
    }

    final topLeft = stack.globalToLocal(target.localToGlobal(Offset.zero));

    return topLeft & target.size;
  }

  Widget _writingMark() {
    final showCaret = !_entrance.isCompleted && _showCaret;

    if (_visibleWord != _word) {
      return _SplashMark(visible: _visibleWord, showCaret: showCaret);
    }

    return AuthBrandMark(key: _lettersKey, showCaret: showCaret);
  }

  String get _visibleWord {
    if (_splashT <= 0 || _word.isEmpty) {
      return '';
    }

    // ceil inclui a última letra antes do progresso chegar a 1. Com floor,
    // o "r" só aparecia no instante em que o formulário substituía o splash.
    final count = (_splashT * _word.length).ceil().clamp(0, _word.length);

    return _word.substring(0, count);
  }

  bool get _showCaret => _elapsedMs.round() % 1000 < 560;
}

class _SplashMark extends StatelessWidget {
  const _SplashMark({required this.visible, required this.showCaret});

  final String visible;
  final bool showCaret;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = AuthBrandMark.styleOf(context);

    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: visible),
          if (showCaret)
            TextSpan(
              text: '|',
              style: style?.copyWith(color: theme.colorScheme.primary),
            ),
        ],
      ),
    );
  }
}

class _AuthLayout extends StatelessWidget {
  const _AuthLayout({
    required this.form,
    required this.onIntent,
    required this.onEmail,
    required this.onPassword,
    required this.onPasswordUnfocused,
    required this.onSubmit,
    required this.onSocial,
    required this.brandSlotKey,
    required this.showBrand,
  });

  final AuthFormState form;
  final ValueChanged<AuthIntent> onIntent;
  final ValueChanged<String> onEmail;
  final ValueChanged<String> onPassword;
  final VoidCallback onPasswordUnfocused;
  final VoidCallback onSubmit;
  final ValueChanged<AuthSocial> onSocial;
  final GlobalKey brandSlotKey;
  final bool showBrand;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = constraints.maxWidth >= AppBreakpoints.medium;
        final stage = AuthStage(
          email: form.email,
          password: form.password,
          passwordFocused: form.passwordFocused,
          statusCode: form.statusCode,
          compact: !desktop,
          brandSlotKey: brandSlotKey,
          showBrand: showBrand,
        );
        final fields = AuthForm(
          intent: form.intent,
          email: form.email,
          password: form.password,
          onIntent: onIntent,
          onEmail: onEmail,
          onPassword: onPassword,
          onPasswordUnfocused: onPasswordUnfocused,
          onSubmit: onSubmit,
          onSocial: onSocial,
        );

        if (desktop) {
          return Row(
            children: [
              Expanded(child: stage),
              VerticalDivider(width: 1, color: scheme.outlineVariant),
              Expanded(child: fields),
            ],
          );
        }

        final stageHeight = (constraints.maxHeight * 0.32)
            .clamp(150.0, 220.0)
            .toDouble();

        return Column(
          children: [
            SizedBox(height: stageHeight, child: stage),
            Divider(height: 1, color: scheme.outlineVariant),
            Expanded(child: fields),
          ],
        );
      },
    );
  }
}
