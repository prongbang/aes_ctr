import Flutter
import UIKit

public class SwiftAesCtrPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "aes_ctr", binaryMessenger: registrar.messenger())
        let instance = SwiftAesCtrPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let aesCtrCryptography = AesCtrCryptography.getInstance()
        guard let arguments = call.arguments as? [String: Any] else {
            return
        }
        
        let counter = arguments["counter"] as? NSNumber
        let secretKey = arguments["secretKey"] as? FlutterStandardTypedData
        
        switch call.method {
        case "encrypt":
            let plaintext = arguments["plaintext"] as? String
            if plaintext != nil && counter != nil && secretKey != nil {
                result(aesCtrCryptography.encrypt(counter: counter!, secretKey: secretKey!, plaintext: plaintext!))
            }
            break
        case "decrypt":
            let cipher = arguments["cipher"] as? String
            if cipher != nil && counter != nil && secretKey != nil {
                result(aesCtrCryptography.decrypt(counter: counter!, secretKey: secretKey!, cipher: cipher!))
            }
            break
        default:
            result("")
        }
    }
}
