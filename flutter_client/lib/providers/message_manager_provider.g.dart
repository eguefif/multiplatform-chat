// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_manager_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messageManagerHash() => r'16e5bd8d416da90265838b13f7bd0053fcaa68b8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [messageManager].
@ProviderFor(messageManager)
const messageManagerProvider = MessageManagerFamily();

/// See also [messageManager].
class MessageManagerFamily extends Family<void> {
  /// See also [messageManager].
  const MessageManagerFamily();

  /// See also [messageManager].
  MessageManagerProvider call(
    String message,
  ) {
    return MessageManagerProvider(
      message,
    );
  }

  @override
  MessageManagerProvider getProviderOverride(
    covariant MessageManagerProvider provider,
  ) {
    return call(
      provider.message,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messageManagerProvider';
}

/// See also [messageManager].
class MessageManagerProvider extends AutoDisposeProvider<void> {
  /// See also [messageManager].
  MessageManagerProvider(
    String message,
  ) : this._internal(
          (ref) => messageManager(
            ref as MessageManagerRef,
            message,
          ),
          from: messageManagerProvider,
          name: r'messageManagerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messageManagerHash,
          dependencies: MessageManagerFamily._dependencies,
          allTransitiveDependencies:
              MessageManagerFamily._allTransitiveDependencies,
          message: message,
        );

  MessageManagerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.message,
  }) : super.internal();

  final String message;

  @override
  Override overrideWith(
    void Function(MessageManagerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MessageManagerProvider._internal(
        (ref) => create(ref as MessageManagerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        message: message,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<void> createElement() {
    return _MessageManagerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessageManagerProvider && other.message == message;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, message.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MessageManagerRef on AutoDisposeProviderRef<void> {
  /// The parameter `message` of this provider.
  String get message;
}

class _MessageManagerProviderElement extends AutoDisposeProviderElement<void>
    with MessageManagerRef {
  _MessageManagerProviderElement(super.provider);

  @override
  String get message => (origin as MessageManagerProvider).message;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
