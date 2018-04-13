package com.github.caijinglong.flutterwanandroid

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.net.http.SslError
import android.os.Build
import android.os.Bundle
import android.webkit.*

/**
 * Created by cai on 2018/4/13.
 */
class WebActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val webview = WebView(this)
        setContentView(webview)

        val url = intent.getStringExtra(URL)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            webview.settings.mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW
        }
        webview.settings.javaScriptEnabled = true
        webview.settings.cacheMode = WebSettings.LOAD_NO_CACHE
        webview.webChromeClient = object : WebChromeClient() {
        }

        webview.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {


//                view?.loadUrl(url)
                return true
            }

            override fun onReceivedSslError(view: WebView?, handler: SslErrorHandler?, error: SslError?) {
//                super.onReceivedSslError(view, handler, error)
                handler?.proceed()
            }

            override fun shouldOverrideUrlLoading(view: WebView?, url: String?): Boolean {
                url?.let {
                    if (url.trim().startsWith("tel:", true)) {
                        val telArr = url.trim().split(":")
                        val phone = telArr[1]
                        if (phone.isNullOrEmpty().not()) {
                            val intent = Intent(Intent.ACTION_VIEW, Uri.parse(it))
                            startActivity(intent)
                        }
                    }
                    if (it.startsWith("https://") || it.startsWith("http://"))
                        view?.loadUrl(it)
                }

                return true
            }
        }
        webview.loadUrl(url)
    }

    companion object {
        val URL = "_url"

        fun startWebResult(context: Context, url: String) {
            Intent(context, WebActivity::class.java)
                    .apply {
                        putExtra(URL, url)
                        if (context !is Activity) {
                            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        }
                        context.startActivity(this)
                    }
        }
    }


}