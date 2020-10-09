package com.prongbang.aesctr.crypto

import android.annotation.SuppressLint
import org.bouncycastle.util.Arrays
import java.nio.charset.StandardCharsets
import java.security.Security
import javax.crypto.Cipher
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec

/**
 * https://flutter.dev/docs/development/packages-and-plugins/developing-packages
 */
class AesCtrCryptography : Cryptography {

	init {
		Security.addProvider(org.bouncycastle.jce.provider.BouncyCastleProvider())
	}

	@SuppressLint("GetInstance")
	override fun encrypt(counter: Int, secretKey: ByteArray, plaintext: String): String {
		val iv = ByteArray(16)
		Arrays.fill(iv, 0.toByte())
		iv[15] = counter.toByte()

		val key = SecretKeySpec(secretKey, "AES")
		val cipher = Cipher.getInstance("AES/CTR/NoPadding", "BC")

		// Encrypt
		val ivParam = IvParameterSpec(iv)
		cipher.init(Cipher.ENCRYPT_MODE, key, ivParam)
		val encrypted = cipher.doFinal(plaintext.toByteArray())

		return CryptoHelper.toHex(encrypted) ?: ""
	}

	@SuppressLint("GetInstance")
	override fun decrypt(counter: Int, secretKey: ByteArray, cipher: String): String {
		val iv = ByteArray(16)
		Arrays.fill(iv, 0.toByte())
		iv[15] = counter.toByte()

		val key = SecretKeySpec(secretKey, "AES")
		val cipherInstance = Cipher.getInstance("AES/CTR/NoPadding", "BC")

		val ivParam = IvParameterSpec(iv)
		cipherInstance.init(Cipher.ENCRYPT_MODE, key, ivParam)

		val param = cipherInstance.parameters

		val encrypted = CryptoHelper.toByte(cipher)

		cipherInstance.init(Cipher.DECRYPT_MODE, key, param)
		val decryptedByte = cipherInstance.doFinal(encrypted)

		return String(decryptedByte, StandardCharsets.UTF_8)
	}

	companion object {
		fun getInstance(): Cryptography = AesCtrCryptography()
	}
}