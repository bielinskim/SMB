package com.mb.widget

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.widget.RemoteViews

val ACTION_PREV_IMAGE: String = "ACTION_PREV_IMAGE"
val ACTION_NEXT_IMAGE: String = "ACTION_NEXT_IMAGE"
val ACTION_PLAY_MUSIC: String = "ACTION_PLAY_MUSIC"
val ACTION_PAUSE_MUSIC: String = "ACTION_PAUSE_MUSIC"
val ACTION_STOP_MUSIC: String = "ACTION_STOP_MUSIC"
val ACTION_PREV_MUSIC: String = "ACTION_PREV_MUSIC"
val ACTION_NEXT_MUSIC: String = "ACTION_NEXT_MUSIC"

val images = hashMapOf(
    0 to R.drawable.image_1,
    1 to R.drawable.image_2)
var currentImage = 0

class Widget : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)

        if(intent.action == ACTION_PREV_IMAGE) {
            currentImage = Utils.getPrev(currentImage, images.size)

            Utils.setImage(context, images[currentImage]!!)
        }

        if(intent.action == ACTION_NEXT_IMAGE) {
            currentImage = Utils.getNext(currentImage, images.size)

            Utils.setImage(context, images[currentImage]!!)
        }

        if(intent.action == ACTION_PLAY_MUSIC) {
            val current = WidgetPlayer.play(context)

            val views = RemoteViews(context.packageName, R.layout.widget)
            views.setTextViewText(R.id.musicTitle, current.toString())
            val appWidget = ComponentName(context, Widget::class.java)
            val appWidgetManager = AppWidgetManager.getInstance(context)
            appWidgetManager.updateAppWidget(appWidget, views)
        }

        if(intent.action == ACTION_PAUSE_MUSIC) {
            WidgetPlayer.pause()
        }

        if(intent.action == ACTION_STOP_MUSIC) {
            WidgetPlayer.stop()
        }

        if(intent.action == ACTION_PREV_MUSIC) {
            val current = WidgetPlayer.prev(context)

            val views = RemoteViews(context.packageName, R.layout.widget)
            views.setTextViewText(R.id.musicTitle, current.toString())
            val appWidget = ComponentName(context, Widget::class.java)
            val appWidgetManager = AppWidgetManager.getInstance(context)
            appWidgetManager.updateAppWidget(appWidget, views)
        }

        if(intent.action == ACTION_NEXT_MUSIC) {
            val current = WidgetPlayer.next(context)

            val views = RemoteViews(context.packageName, R.layout.widget)
            views.setTextViewText(R.id.musicTitle, current.toString())
            val appWidget = ComponentName(context, Widget::class.java)
            val appWidgetManager = AppWidgetManager.getInstance(context)
            appWidgetManager.updateAppWidget(appWidget, views)
        }
    }
}

internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    val views = RemoteViews(context.packageName, R.layout.widget)

    // open web
    val uri = Uri.parse("https://www.wp.pl")
    val intent = Intent(Intent.ACTION_VIEW, uri)
    val pendingIntent = PendingIntent.getActivity(context, appWidgetId, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
    views.setOnClickPendingIntent(R.id.openWebButton, pendingIntent)

    // set images
    views.setImageViewResource(R.id.widgetImage, images[currentImage]!!)

    Utils.setOnClickPendingIntent(context, appWidgetId, ACTION_PREV_IMAGE, views, R.id.prevImageButton)
    Utils.setOnClickPendingIntent(context, appWidgetId, ACTION_NEXT_IMAGE, views, R.id.nextImageButton)

    // music player
    Utils.setOnClickPendingIntent(context, appWidgetId, ACTION_PLAY_MUSIC, views, R.id.playButton)
    Utils.setOnClickPendingIntent(context, appWidgetId, ACTION_PAUSE_MUSIC, views, R.id.pauseButton)
    Utils.setOnClickPendingIntent(context, appWidgetId, ACTION_PAUSE_MUSIC, views, R.id.pauseButton)
    Utils.setOnClickPendingIntent(context, appWidgetId, ACTION_STOP_MUSIC, views, R.id.stopButton)
    Utils.setOnClickPendingIntent(context, appWidgetId, ACTION_PREV_MUSIC, views, R.id.prevMusicButton)
    Utils.setOnClickPendingIntent(context, appWidgetId, ACTION_NEXT_MUSIC, views, R.id.nextMusicButton)

    appWidgetManager.updateAppWidget(appWidgetId, views)
}