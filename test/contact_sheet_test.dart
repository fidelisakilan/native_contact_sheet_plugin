import 'package:flutter_test/flutter_test.dart';
import 'package:contact_sheet/contact_sheet.dart';
import 'package:contact_sheet/contact_sheet_platform_interface.dart';
import 'package:contact_sheet/contact_sheet_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockContactSheetPlatform
    with MockPlatformInterfaceMixin
    implements ContactSheetPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ContactSheetPlatform initialPlatform = ContactSheetPlatform.instance;

  test('$MethodChannelContactSheet is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelContactSheet>());
  });

  test('getPlatformVersion', () async {
    ContactSheet contactSheetPlugin = ContactSheet();
    MockContactSheetPlatform fakePlatform = MockContactSheetPlatform();
    ContactSheetPlatform.instance = fakePlatform;

    expect(await contactSheetPlugin.getPlatformVersion(), '42');
  });
}
