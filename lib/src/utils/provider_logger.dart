import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ProviderLogger extends ProviderObserver {
  /// Logs all riverpod provider changes
  const ProviderLogger();

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    log(
      'fail: ${provider.name ?? provider.runtimeType}, '
      'error: $error '
      'stackTrace: $stackTrace',
      name: 'Riverpod',
    );
  }

  @override
  void didAddProvider(
    final ProviderBase provider,
    final Object? value,
    final ProviderContainer container,
  ) {
    log(
      'add: ${provider.name ?? provider.runtimeType}, '
      'value: $value',
      name: 'Riverpod',
    );
  }

  @override
  void didUpdateProvider(
    final ProviderBase provider,
    final Object? previousValue,
    final Object? newValue,
    final ProviderContainer container,
  ) {
    log(
      'update: ${provider.name ?? provider.runtimeType}, '
      'value: $newValue',
      name: 'Riverpod',
    );
  }

  @override
  void didDisposeProvider(
    final ProviderBase provider,
    final ProviderContainer container,
  ) {
    log(
      'dispose: ${provider.name ?? provider.runtimeType}',
      name: 'Riverpod',
    );
  }
}

class SentryProviderObserver extends ProviderObserver {
  const SentryProviderObserver();

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    // if (error.toString().contains('Ничего не найдено')) {
    //   return;
    // }

    if (_beforeSend.contains(error.toString())) {
      return;
    }

    Sentry.captureException(
      'Rittersport fail: ${provider.name ?? provider.runtimeType}, '
      'error: $error ',
      stackTrace: stackTrace,
    );
  }

  static const _beforeSend = [
    'Ничего не найдено',
    'title not found',
    'DioException [request cancelled]: The request was manually cancelled by the user.',
    'AniLib недоступен или отсутствует подключение к интернету',
    'Kodik недоступен или отсутствует подключение к интернету',
  ];
}
