package com.prongbang.aesctr

import androidx.annotation.NonNull
import com.prongbang.aesctr.crypto.AesCtrCryptography
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** AesCtrPlugin */
class AesCtrPlugin : FlutterPlugin, MethodCallHandler {
	/// The MethodChannel that will the communication between Flutter and native Android
	///
	/// This local reference serves to register the plugin with the Flutter Engine and unregister it
	/// when the Flutter Engine is detached from the Activity
	private lateinit var channel: MethodChannel

	override fun onAttachedToEngine(
			@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
		channel = MethodChannel(flutterPluginBinding.binaryMessenger, "aes_ctr")
		channel.setMethodCallHandler(AesCtrPlugin())
	}

	override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
		val aesCtrCryptography = AesCtrCryptography.getInstance()
		val counter: Int? = call.argument("counter")
		val secretKey: ByteArray? = call.argument("secretKey")
		when (call.method) {
			"encrypt" -> {
				val plaintext: String? = call.argument("plaintext")
				if (counter != null && secretKey != null && plaintext != null) {
					result.success(aesCtrCryptography.encrypt(counter, secretKey, plaintext))
				}
			}
			"decrypt" -> {
				val cipher: String? = call.argument("cipher")
				if (counter != null && secretKey != null && cipher != null) {
					result.success(aesCtrCryptography.decrypt(counter, secretKey, cipher))
				}
			}
			else -> {
				result.notImplemented()
			}
		}
	}

	override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
		channel.setMethodCallHandler(null)
	}
}
