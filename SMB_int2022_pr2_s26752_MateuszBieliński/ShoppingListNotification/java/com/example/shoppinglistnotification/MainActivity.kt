package com.example.shoppinglistnotification

import android.content.*
import android.os.Bundle
import android.os.IBinder
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    lateinit var receiver: BroadcastReceiver
    private lateinit var mserv: NotificationService
    private var mBound: Boolean = false

    val mcom = object: ServiceConnection {
        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
            val binder = service as NotificationService.MyBinder
            mserv = binder.getService()
            mBound = true
        }
        override fun onServiceDisconnected(name: ComponentName?) {
            mBound = false
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        receiver = object: BroadcastReceiver(){
            override fun onReceive(context: Context?, intent: Intent?) {
                    mserv.showNotification(intent)
            }
        }
    }

    override fun onStart() {
        super.onStart()
        val intent = Intent(this, NotificationService::class.java)
        bindService(intent, mcom, Context.BIND_AUTO_CREATE)
        val permission = "com.example.shoppinglistnotification.RECEIVE_INTENT"
        registerReceiver(receiver,
            IntentFilter("com.example.shoppinglist.ADD_PRODUCT"),
            permission,
            null
        )
    }

}