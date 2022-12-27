package com.example.flutter_application_1
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
     private val CHANNEL = "com.example/youtube"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      if (call.method == "openYoutubeVideo") {
        val videoId = call.argument<String>("videoId")
        val appIntent = Intent(Intent.ACTION_VIEW, Uri.parse("vnd.youtube:$videoId"))
        val webIntent = Intent(Intent.ACTION_VIEW, Uri.parse("http://www.youtube.com/watch?v=$videoId"))
        try {
          startActivity(appIntent)
        } catch (ex: android.content.ActivityNotFoundException) {
          startActivity(webIntent)
        }
      }
      result.success(null)
    }
  }
}
