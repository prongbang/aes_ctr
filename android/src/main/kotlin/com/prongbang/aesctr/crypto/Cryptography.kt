package com.prongbang.aesctr.crypto

interface Cryptography {
	fun encrypt(counter: Int, secretKey: ByteArray, plaintext: String): String
	fun decrypt(counter: Int, secretKey: ByteArray, cipher: String): String
}