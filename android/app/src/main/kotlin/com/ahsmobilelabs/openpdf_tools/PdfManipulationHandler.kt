package com.ahsmobilelabs.openpdf_tools

import android.content.Context
import io.flutter.plugin.common.MethodChannel

class PdfManipulationHandler(private val context: Context) {
    fun handleMethodCall(call: Any, result: Any) {
        // Just return success for all calls to test if compilation works
        // The cast and actual method handling will be done in MainActivity
    }
}
