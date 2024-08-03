package com.example.shoppinglist

import android.content.Context
import android.util.Log
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase


@Database(entities = [Product::class], version = 1)
public abstract class ProductDB : RoomDatabase() {
    abstract fun productDao(): ProductDao

    //singleton
    companion object {
        private var instance: ProductDB? = null
        fun getDatabase(context: Context): ProductDB {
            val tmpInst = instance
            if (tmpInst != null) {
                return tmpInst
            }
            val inst = Room.databaseBuilder(
                context.applicationContext,
                ProductDB::class.java,
                "product_DB"
            ).allowMainThreadQueries().build() //allowMainThread nierekomendowany
            instance = inst
            return inst
        }
    }
}
