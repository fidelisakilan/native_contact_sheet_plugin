import 'contact_sheet_platform_interface.dart';

class ContactSheet {
  Future<void> open({
    String? name,
    String? email,
    List<String>? phone,
    String? org,
  }) {
    return ContactSheetPlatform.instance.open(
        email: email, name: name, phone: phone, org: org);
  }
}
