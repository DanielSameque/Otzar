import 'package:flutter/material.dart';

/// Realce sutil do snippet, usando apenas papéis do [ColorScheme].
List<InlineSpan> highlightAuthCode(String source, ColorScheme scheme) {
  final keyword = TextStyle(color: scheme.primary);
  final stringStyle = TextStyle(color: scheme.tertiary);
  final comment = TextStyle(color: scheme.outline);
  final plain = TextStyle(color: scheme.onSurface);
  const keywords = {
    'const',
    'async',
    'await',
    'if',
    'throw',
    'new',
    'return',
    'null',
  };
  final spans = <InlineSpan>[];
  final buffer = StringBuffer();

  void flushPlain() {
    if (buffer.isEmpty) {
      return;
    }

    spans.add(TextSpan(text: buffer.toString(), style: plain));
    buffer.clear();
  }

  var index = 0;

  while (index < source.length) {
    if (source.startsWith('//', index)) {
      flushPlain();
      final end = source.indexOf('\n', index);
      final stop = end == -1 ? source.length : end;
      final text = source.substring(index, stop);
      spans.add(
        TextSpan(text: text, style: _commentStyle(text, scheme, comment)),
      );
      index = stop;
      continue;
    }

    final quote = source[index];

    if (quote == "'" || quote == '"' || quote == '`') {
      flushPlain();
      var cursor = index + 1;

      while (cursor < source.length && source[cursor] != quote) {
        cursor++;
      }

      if (cursor < source.length) {
        cursor++;
      }

      spans.add(
        TextSpan(text: source.substring(index, cursor), style: stringStyle),
      );
      index = cursor;
      continue;
    }

    if (_isIdentStart(source.codeUnitAt(index))) {
      flushPlain();
      var cursor = index + 1;

      while (cursor < source.length &&
          _isIdentPart(source.codeUnitAt(cursor))) {
        cursor++;
      }

      final word = source.substring(index, cursor);
      spans.add(
        TextSpan(text: word, style: keywords.contains(word) ? keyword : plain),
      );
      index = cursor;
      continue;
    }

    buffer.write(source[index]);
    index++;
  }

  flushPlain();

  return spans;
}

TextStyle _commentStyle(String text, ColorScheme scheme, TextStyle comment) {
  final match = RegExp(r'// status:\s*(\d+)').firstMatch(text);

  if (match == null) {
    return comment;
  }

  final code = int.tryParse(match.group(1)!);

  if (code == null) {
    return comment;
  }

  if (code >= 400) {
    return comment.copyWith(color: scheme.error);
  }

  return comment.copyWith(color: scheme.primary);
}

bool _isIdentStart(int unit) {
  return (unit >= 65 && unit <= 90) ||
      (unit >= 97 && unit <= 122) ||
      unit == 95 ||
      unit == 36;
}

bool _isIdentPart(int unit) {
  return _isIdentStart(unit) || (unit >= 48 && unit <= 57);
}
