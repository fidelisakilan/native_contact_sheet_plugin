import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'contact_sheet_method_channel.dart';

abstract class ContactSheetPlatform extends PlatformInterface {
  /// Constructs a ContactSheetPlatform.
  ContactSheetPlatform() : super(token: _token);

  static final Object _token = Object();

  static ContactSheetPlatform _instance = MethodChannelContactSheet();

  /// The default instance of [ContactSheetPlatform] to use.
  ///
  /// Defaults to [MethodChannelContactSheet].
  static ContactSheetPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ContactSheetPlatform] when
  /// they register themselves.
  static set instance(ContactSheetPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> open({
    String? name,
    String? email,
    List<String>? phone,
    String? org,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
