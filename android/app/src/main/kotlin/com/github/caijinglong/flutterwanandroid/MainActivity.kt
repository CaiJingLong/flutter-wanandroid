package com.github.caijinglong.flutterwanandroid

import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity() : FlutterActivity() {
    companion object {
        private const val CHANNEL = "com.github.caijinglong.flutterwanandroid"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "starturl") {
                val url: String = call.arguments as String
                WebActivity.startWebResult(this@MainActivity, url)
            }
        }
    }

}
