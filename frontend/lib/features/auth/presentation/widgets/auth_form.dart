import 'package:flutter/material.dart';

import '../../domain/auth_provider.dart';

/// Formulário da jornada: login, criar conta ou recuperar senha.
class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.intent,
    required this.email,
    required this.password,
    required this.onIntent,
    required this.onEmail,
    required this.onPassword,
    required this.onPasswordUnfocused,
    required this.onSubmit,
    required this.onSocial,
  });

  final AuthIntent intent;
  final String email;
  final String password;
  final ValueChanged<AuthIntent> onIntent;
  final ValueChanged<String> onEmail;
  final ValueChanged<String> onPassword;
  final VoidCallback onPasswordUnfocused;
  final VoidCallback onSubmit;
  final ValueChanged<AuthSocial> onSocial;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final FocusNode _passwordFocus;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: widget.email);
    _password = TextEditingController(text: widget.password);
    _passwordFocus = FocusNode()..addListener(_onPasswordFocusChanged);
  }

  void _onPasswordFocusChanged() {
    if (_passwordFocus.hasFocus) {
      return;
    }

    widget.onPasswordUnfocused();
  }

  @override
  void didUpdateWidget(AuthForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.email != _email.text) {
      _email.value = TextEditingValue(
        text: widget.email,
        selection: TextSelection.collapsed(offset: widget.email.length),
      );
    }

    if (widget.password != _password.text) {
      _password.value = TextEditingValue(
        text: widget.password,
        selection: TextSelection.collapsed(offset: widget.password.length),
      );
    }
  }

  @override
  void dispose() {
    _passwordFocus.removeListener(_onPasswordFocusChanged);
    _passwordFocus.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final showPassword = widget.intent != AuthIntent.resetPassword;
    final showSocial = widget.intent != AuthIntent.resetPassword;

    return LayoutBuilder(
      builder: (context, constraints) {
        final inset = MediaQuery.viewInsetsOf(context).bottom;
        final minHeight = (constraints.maxHeight - 48 - inset).clamp(
          0.0,
          double.infinity,
        );

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(28, 24, 28, 24 + inset),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(_title, style: theme.textTheme.headlineMedium),
                    const SizedBox(height: 28),
                    TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: showPassword
                          ? TextInputAction.next
                          : TextInputAction.done,
                      autofillHints: const [AutofillHints.email],
                      decoration: const InputDecoration(labelText: 'E-mail'),
                      onChanged: widget.onEmail,
                      onSubmitted: showPassword
                          ? null
                          : (_) => widget.onSubmit(),
                    ),
                    if (showPassword) ...[
                      const SizedBox(height: 16),
                      TextField(
                        controller: _password,
                        focusNode: _passwordFocus,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.password],
                        decoration: const InputDecoration(labelText: 'Senha'),
                        onChanged: widget.onPassword,
                        onSubmitted: (_) => widget.onSubmit(),
                      ),
                    ],
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: widget.onSubmit,
                      child: Text(_submitLabel),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (final link in _links)
                          TextButton(
                            onPressed: () => widget.onIntent(link.intent),
                            child: Text(link.label),
                          ),
                      ],
                    ),
                    if (showSocial) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(color: scheme.outlineVariant),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'ou',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: scheme.outline,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(color: scheme.outlineVariant),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          for (final social in AuthSocial.values) ...[
                            if (social != AuthSocial.google)
                              const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => widget.onSocial(social),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(social.label),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String get _title => switch (widget.intent) {
    AuthIntent.signIn => 'Bem-vindo',
    AuthIntent.signUp => 'Criar conta',
    AuthIntent.resetPassword => 'Recuperar senha',
  };

  String get _submitLabel => switch (widget.intent) {
    AuthIntent.signIn => 'Entrar',
    AuthIntent.signUp => 'Criar conta',
    AuthIntent.resetPassword => 'Enviar',
  };

  List<({String label, AuthIntent intent})> get _links =>
      switch (widget.intent) {
        AuthIntent.signIn => [
          (label: 'Esqueci minha senha', intent: AuthIntent.resetPassword),
          (label: 'Criar conta', intent: AuthIntent.signUp),
        ],
        AuthIntent.signUp => [
          (label: 'Já tenho conta', intent: AuthIntent.signIn),
        ],
        AuthIntent.resetPassword => [
          (label: 'Voltar ao login', intent: AuthIntent.signIn),
        ],
      };
}
