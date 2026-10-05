import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/auth_code_snippet.dart';
import 'auth_code_highlight.dart';

/// Palavra da marca, no mesmo estilo do splash, para a transição e o painel.
class AuthBrandMark extends StatelessWidget {
  const AuthBrandMark({super.key, this.showCaret = false, this.style});

  static const String text = 'Otzar';

  final bool showCaret;
  final TextStyle? style;

  static TextStyle? styleOf(BuildContext context) {
    return Theme.of(context).textTheme.displayLarge?.copyWith(
      fontWeight: FontWeight.w500,
      letterSpacing: 1.4,
    );
  }

  static TextStyle? codeStyleOf(BuildContext context) {
    final theme = Theme.of(context);

    return theme.textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w500,
      letterSpacing: 1.1,
      color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = this.style ?? styleOf(context);

    return Text.rich(
      TextSpan(
        style: style,
        children: [
          const TextSpan(text: text),
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

/// Painel esquerdo (ou superior): pulso da marca ou o snippet em digitação.
class AuthStage extends StatefulWidget {
  const AuthStage({
    super.key,
    required this.email,
    required this.password,
    required this.passwordFocused,
    required this.statusCode,
    required this.compact,
    required this.brandSlotKey,
    required this.showBrand,
  });

  final String email;
  final String password;
  final bool passwordFocused;
  final int? statusCode;
  final bool compact;

  /// Reserva o lugar da marca para a palavra que vem do splash.
  final GlobalKey brandSlotKey;

  /// Quando falso, a marca ocupa espaço mas não é desenhada.
  final bool showBrand;

  @override
  State<AuthStage> createState() => _AuthStageState();
}

class _AuthStageState extends State<AuthStage> with TickerProviderStateMixin {
  late final AnimationController _pulse;
  late final AnimationController _brandMove;
  late final AnimationController _emailProgress;
  late final AnimationController _passwordProgress;
  final ScrollController _codeScroll = ScrollController();
  String _lastSource = '';

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _brandMove = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      value: _showingCode ? 1 : 0,
    );
    _brandMove.addStatusListener((status) {
      if (!mounted) {
        return;
      }

      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _syncPulse();
      }
    });
    _syncPulse();
    _emailProgress = AnimationController(vsync: this, value: _emailTarget);
    _passwordProgress = AnimationController(
      vsync: this,
      value: _passwordTarget,
    );
  }

  @override
  void didUpdateWidget(AuthStage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final wasShowingCode =
        oldWidget.email.isNotEmpty ||
        oldWidget.password.isNotEmpty ||
        oldWidget.statusCode != null;

    if (wasShowingCode != _showingCode) {
      _pulse.stop();
      _pulse.value = 1;
      _brandMove.animateTo(
        _showingCode ? 1 : 0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    }

    _syncPulse();
    _emailProgress.animateTo(
      _emailTarget,
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOutCubic,
    );
    _passwordProgress.animateTo(
      _passwordTarget,
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOutCubic,
    );
  }

  double get _emailTarget => AuthCodeSnippet.progressFor(
    widget.email.length,
    AuthCodeSnippet.emailReferenceLength,
  );

  double get _passwordTarget => AuthCodeSnippet.passwordRevealProgress(
    length: widget.password.length,
    focused: widget.passwordFocused,
  );

  bool get _showingCode =>
      widget.email.isNotEmpty ||
      widget.password.isNotEmpty ||
      widget.statusCode != null;

  void _syncPulse() {
    final idle =
        widget.showBrand &&
        !_showingCode &&
        !_brandMove.isAnimating &&
        _brandMove.value == 0;

    if (!idle) {
      if (_showingCode || _brandMove.value > 0) {
        _pulse.stop();
        _pulse.value = 1;
      }
      return;
    }

    if (_pulse.isAnimating) {
      return;
    }

    _pulse.value = 1;
    _pulse.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    _brandMove.dispose();
    _emailProgress.dispose();
    _passwordProgress.dispose();
    _codeScroll.dispose();
    super.dispose();
  }

  void _revealLatest(String source) {
    if (source == _lastSource) {
      return;
    }

    _lastSource = source;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_codeScroll.hasClients) {
        return;
      }

      _codeScroll.jumpTo(_codeScroll.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: scheme.surfaceContainerLow,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _pulse,
          _brandMove,
          _emailProgress,
          _passwordProgress,
        ]),
        builder: (context, _) {
          final source = AuthCodeSnippet.revealProgress(
            emailProgress: _emailProgress.value,
            passwordProgress: _passwordProgress.value,
            statusCode: widget.statusCode,
          );

          if (_showingCode) {
            _revealLatest(source);
          }

          final move = _brandMove.value;
          final showCode = _showingCode || _brandMove.value > 0;

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? 20 : 36,
              vertical: widget.compact ? 16 : 32,
            ),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.topLeft,
              children: [
                if (showCode)
                  Opacity(
                    opacity: move,
                    child: _CodeLayout(
                      source: source,
                      compact: widget.compact,
                      scrollController: _codeScroll,
                    ),
                  ),
                _MovingBrand(
                  move: move,
                  pulse: _pulse.value,
                  showBrand: widget.showBrand,
                  brandKey: widget.brandSlotKey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MovingBrand extends StatelessWidget {
  const _MovingBrand({
    required this.move,
    required this.pulse,
    required this.showBrand,
    required this.brandKey,
  });

  final double move;
  final double pulse;
  final bool showBrand;
  final GlobalKey brandKey;

  @override
  Widget build(BuildContext context) {
    final idle = AuthBrandMark.styleOf(context);
    final code = AuthBrandMark.codeStyleOf(context);
    final style = TextStyle.lerp(idle, code, move);
    final pulseOpacity = 0.82 + (pulse * 0.18);
    final opacity = showBrand
        ? pulseOpacity + ((1 - pulseOpacity) * move)
        : 0.0;
    final scale = 1 + (pulse * 0.03) * (1 - move);

    return Align(
      alignment: Alignment.lerp(Alignment.center, Alignment.topLeft, move)!,
      child: ExcludeSemantics(
        excluding: !showBrand,
        child: Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            child: AuthBrandMark(key: brandKey, style: style),
          ),
        ),
      ),
    );
  }
}

class _CodeLayout extends StatelessWidget {
  const _CodeLayout({
    required this.source,
    required this.compact,
    required this.scrollController,
  });

  final String source;
  final bool compact;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final codeStyle = GoogleFonts.jetBrainsMono(
      fontSize: compact ? 11 : 13,
      height: 1.5,
      color: scheme.onSurface,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExcludeSemantics(
          child: Opacity(
            opacity: 0,
            child: Text('Otzar', style: AuthBrandMark.codeStyleOf(context)),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'auth.js',
          style: theme.textTheme.labelSmall?.copyWith(color: scheme.outline),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Text.rich(
              TextSpan(
                style: codeStyle,
                children: highlightAuthCode(source, scheme),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
