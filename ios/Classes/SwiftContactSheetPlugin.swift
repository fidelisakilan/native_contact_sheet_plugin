import Flutter
import UIKit
import Contacts
import ContactsUI

public class SwiftContactSheetPlugin: NSObject, FlutterPlugin, CNContactViewControllerDelegate {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "contact_sheet", binaryMessenger: registrar.messenger())
    let instance = SwiftContactSheetPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if (call.method == "openContactSheet") {
        showAddContactSheet(call, result: result)
      } else {
          result(FlutterMethodNotImplemented)
      }
  }

  private func showAddContactSheet(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      print("showAddContactSheet")
        if let args = call.arguments as? Dictionary<String, Any>,
            let name = args["name"] as? String,
            let phoneNumbers = args["phone"] as? Array<String>,
            let email = args["email"] as? String,
            let org = args["org"] as? String
        {
            let newContact = CNMutableContact()
            newContact.givenName = name
            
            for phone in phoneNumbers{
                newContact.phoneNumbers.append(CNLabeledValue(label: "phone", value: CNPhoneNumber(stringValue: phone)))
            }
            
            
            
            newContact.organizationName = org
            newContact.emailAddresses = [CNLabeledValue(label: "email", value:email as NSString )]
            let contactVC = CNContactViewController(forNewContact: newContact)
            contactVC.contactStore = CNContactStore()
            contactVC.delegate = self
            contactVC.allowsActions = false
            let navigationController = UINavigationController(rootViewController: contactVC)
            if #available(iOS 13.0, *) {
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .compactMap({$0 as? UIWindowScene})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                keyWindow?.rootViewController?.present(navigationController, animated: true, completion: nil)
            }
          }
    }
}
