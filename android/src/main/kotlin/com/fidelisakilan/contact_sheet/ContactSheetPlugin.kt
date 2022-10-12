package com.fidelisakilan.contact_sheet

import android.app.Activity
import android.content.ContentValues
import android.content.Intent
import android.provider.ContactsContract
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ContactSheetPlugin */
class ContactSheetPlugin: FlutterPlugin, MethodCallHandler,ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "contact_sheet")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "openContactSheet") {
      val name = call.argument<String>("name")
      val phone = call.argument<List<String>>("phone")
      val email = call.argument<String>("email")
      val org = call.argument<String>("org")
      addContact(name!!, phone!!, email!!, org!!)
      result.success(null)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun addContact(name: String, phoneList: List<String>, email: String, org: String) {
    val i = Intent(Intent.ACTION_INSERT)
    val data: ArrayList<ContentValues> = ArrayList<ContentValues>()

    i.type = ContactsContract.Contacts.CONTENT_TYPE
    i.putExtra(ContactsContract.Intents.Insert.NAME, name)
    phoneList.forEach {
      val row = ContentValues()
      row.put(
        ContactsContract.Data.MIMETYPE,
        ContactsContract.CommonDataKinds.Phone.CONTENT_ITEM_TYPE
      )
      row.put(ContactsContract.CommonDataKinds.Phone.NUMBER, it)
      row.put(
        ContactsContract.CommonDataKinds.Phone.TYPE,
        ContactsContract.CommonDataKinds.Phone.TYPE_OTHER
      );
      data.add(row)
    }
    i.putExtra(ContactsContract.Intents.Insert.EMAIL, email)
    i.putExtra(ContactsContract.Intents.Insert.COMPANY, org)
    i.putParcelableArrayListExtra(ContactsContract.Intents.Insert.DATA, data)
    activity?.startActivity(i)
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

}
