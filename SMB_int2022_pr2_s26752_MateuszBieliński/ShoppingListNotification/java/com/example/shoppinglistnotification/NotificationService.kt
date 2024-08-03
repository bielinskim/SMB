package com.example.shoppinglistnotification

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Binder
import android.os.Build
import android.os.IBinder
import android.util.Log
import android.widget.Toast
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat

class NotificationService : Service() {

    val CHANNEL_ID: String = "0"
    val CHANNEL_NAME: String = "shoppinglist"
    private lateinit var mBinder: MyBinder
    var id = 0

    init{
        mBinder = MyBinder()
    }

    inner class MyBinder : Binder() {
        fun getService(): NotificationService = this@NotificationService
    }
    override fun onBind(intent: Intent): IBinder {
        createNotificationChannel()

        return mBinder
    }

    fun showNotification(receivedIntent: Intent?) {

            if(receivedIntent?.extras != null) {
                val productId = receivedIntent.extras!!.getInt("productId")
                val productName = receivedIntent.extras!!.getString("productName")
                val productAmount = receivedIntent.extras!!.getInt("productAmount")
                val productPrice = receivedIntent.extras!!.getDouble("productPrice")
                val productIsBought = receivedIntent.extras!!.getBoolean("productIsBought")

                val notificationIntent = Intent("com.example.shoppinglist.productformactivity")
                notificationIntent.putExtra("productId", productId)
                notificationIntent.putExtra("productName", productName)
                notificationIntent.putExtra("productAmount", productAmount)
                notificationIntent.putExtra("productPrice", productPrice)
                notificationIntent.putExtra("productIsBought", productIsBought)

                val pendingIntent = PendingIntent.getActivity(
                    this,
                    0,
                    notificationIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
                val notification = NotificationCompat.Builder(this,
                    CHANNEL_ID)
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .setContentTitle("Aplikacja ShoppingList - dodano nowy produkt")
                    .setContentText("Nazwa produktu: $productName, ilość: $productAmount, cena: $productPrice")
                    .setContentIntent(pendingIntent)
                    .setAutoCancel(true)
                    .build()
                val notificationManager = NotificationManagerCompat.from(this)
                notificationManager.notify(id++, notification)
            }

        }

    fun createNotificationChannel(){
        if(Build.VERSION.SDK_INT < Build.VERSION_CODES.O)
            return

        val notificationChannel = NotificationChannel(
            CHANNEL_ID,
            CHANNEL_NAME,
            NotificationManager.IMPORTANCE_DEFAULT
        )
        notificationChannel.description =
            "Dodanie produktu"

        val notificationManager = NotificationManagerCompat.from(this)
        notificationManager.createNotificationChannel(notificationChannel)
    }
    }


