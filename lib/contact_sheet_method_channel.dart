import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'contact_sheet_platform_interface.dart';

/// An implementation of [ContactSheetPlatform] that uses method channels.
class MethodChannelContactSheet extends ContactSheetPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('contact_sheet');

  @override
  Future<void> open({
    String? name,
    String? email,
    List<String>? phone,
    String? org,
  }) async {
    final params = {
      'name': name,
      'email': email,
      'phone': phone,
      'org': org,
    };
    await methodChannel.invokeMethod<String>('openContactSheet', params);
  }
}
