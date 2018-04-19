package com.github.caijinglong.flutterwanandroid

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.net.Uri
import android.net.http.SslError
import android.os.Build
import android.os.Bundle
import android.support.v7.app.ActionBar
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.Toolbar
import android.view.MenuItem
import android.webkit.*

/**
 * Created by cai on 2018/4/13.
 */
class WebActivity : AppCompatActivity() {

    lateinit var toolbar: Toolbar

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_web)

        val webView = findViewById<WebView>(R.id.webView)

        toolbar = findViewById(R.id.toolbar)
        initToolbar()


        val url = intent.getStringExtra(URL)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            webView.settings.mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW
        }
        webView.settings.javaScriptEnabled = true
        webView.settings.cacheMode = WebSettings.LOAD_NO_CACHE
        webView.webChromeClient = object : WebChromeClient() {
            override fun onReceivedTitle(view: WebView?, title: String?) {
                super.onReceivedTitle(view, title)
                toolbar.title = title
            }
        }

        webView.webViewClient = object : WebViewClient() {
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
        webView.loadUrl(url)
    }

    private fun initToolbar() {
        toolbar.setNavigationOnClickListener { finish() }
        toolbar.setTitleTextColor(Color.WHITE)
        toolbar.setNavigationIcon(R.drawable.icon_close)
        toolbar.setBackgroundColor(Color.parseColor("#42A5F5"))
        toolbar.setTitleTextAppearance(this, R.style.toolbar_title)
    }

    override fun getSupportActionBar(): ActionBar? {
        return super.getSupportActionBar()
    }

    override fun onOptionsItemSelected(item: MenuItem?): Boolean {
        when (item?.itemId) {
            android.R.id.home -> finish()
        }
        return super.onOptionsItemSelected(item)
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