package com.github.caijinglong.flutterwanandroid

import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity() : FlutterActivity() {
    companion object {
        private const val CHANNEL = "com.github.caijinglong.flutterwanandroid"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                object : MethodCallHandler {
                    @Override
                    override fun onMethodCall(call: MethodCall, result: Result) {
                        if (call.method == "starturl") {
                            val url: String = call.arguments as String
                            WebActivity.startWebResult(this@MainActivity, url)
                        }
                    }
                })
    }

}
