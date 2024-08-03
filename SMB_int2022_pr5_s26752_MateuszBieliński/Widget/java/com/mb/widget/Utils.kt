package com.mb.widget

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

class Utils {
    companion object {
        fun getPrev(current: Int, lenght: Int): Int {
            val prev = current - 1

            return if(prev < 0) {
                lenght - 1
            } else {
                prev
            }
        }

        fun getNext(current: Int, lenght: Int): Int {
            val next = current + 1

            return if(next >= lenght) {
                0
            } else {
                next
            }
        }

        fun setOnClickPendingIntent(context: Context, appWidgetId: Int, action: String, views: RemoteViews, buttonId: Int) {
            val intent = Intent(context, Widget::class.java)
            intent.action = action
            val clickFirstPendingIntent = PendingIntent.getBroadcast(context, appWidgetId, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
            views.setOnClickPendingIntent(buttonId, clickFirstPendingIntent)
        }

        fun setImage(context: Context, image: Int) {
            val views = RemoteViews(context.packageName, R.layout.widget)

            views.setImageViewResource(R.id.widgetImage, image)

            val appWidget = ComponentName(context, Widget::class.java)
            val appWidgetManager = AppWidgetManager.getInstance(context)
            appWidgetManager.updateAppWidget(appWidget, views)
        }
    }
}