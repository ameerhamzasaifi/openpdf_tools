package com.ahsmobilelabs.openpdf_tools

import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val PDF_OPENER_CHANNEL = "com.openpdf.tools/pdfOpener"
    private val PDF_MANIPULATION_CHANNEL = "com.openpdf.tools/pdfManipulation"
    private var pdfFilePath: String? = null
    private lateinit var pdfManipulationHandler: PdfManipulationHandler

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Initialize PDF manipulation handler
        pdfManipulationHandler = PdfManipulationHandler(this)

        // Set up PDF Opener channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PDF_OPENER_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "registerPdfOpener" -> {
                        result.success(true)
                    }
                    "getReceivedPdfPath" -> {
                        val path = extractPdfPathFromIntent()
                        result.success(path)
                    }
                    else -> result.notImplemented()
                }
            }

        // Set up PDF Manipulation channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PDF_MANIPULATION_CHANNEL)
            .setMethodCallHandler { call, result ->
                pdfManipulationHandler.handleMethodCall(call, result)
            }

        // Handle intent that started this activity
        handleIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent) {
        if (intent.action == Intent.ACTION_VIEW) {
            val uri = intent.data
            if (uri != null && isPdfFile(uri)) {
                pdfFilePath = getFilePathFromUri(uri)
                // Send to Flutter
                sendPdfPathToFlutter(pdfFilePath)
            }
        }
    }

    private fun extractPdfPathFromIntent(): String? {
        val uri = intent?.data
        return if (uri != null && isPdfFile(uri)) {
            getFilePathFromUri(uri)
        } else {
            null
        }
    }

    private fun getFilePathFromUri(uri: Uri): String? {
        return when {
            uri.scheme == "file" -> uri.path
            uri.scheme == "content" -> getPathFromContentUri(uri)
            uri.scheme == "openpdf" -> {
                // Handle custom deep link: openpdf://file/path/to/file.pdf
                uri.pathSegments.drop(1).joinToString("/")
            }
            else -> uri.toString()
        }
    }

    private fun getPathFromContentUri(uri: Uri): String? {
        return try {
            val projection = arrayOf(android.provider.MediaStore.MediaColumns.DATA)
            val cursor = contentResolver.query(uri, projection, null, null, null)
            cursor?.use {
                if (it.moveToFirst()) {
                    val columnIndex = it.getColumnIndexOrThrow(android.provider.MediaStore.MediaColumns.DATA)
                    cursor.getString(columnIndex)
                } else {
                    uri.path
                }
            }
        } catch (e: Exception) {
            // Fallback to path
            uri.path
        }
    }

    private fun isPdfFile(uri: Uri): Boolean {
        val mimeType = contentResolver.getType(uri)
        val path = uri.path ?: uri.toString()
        return mimeType == "application/pdf" || path.endsWith(".pdf", ignoreCase = true)
    }

    private fun sendPdfPathToFlutter(path: String?) {
        if (path != null) {
            MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, PDF_OPENER_CHANNEL)
                .invokeMethod("openPdf", path)
        }
    }
}
