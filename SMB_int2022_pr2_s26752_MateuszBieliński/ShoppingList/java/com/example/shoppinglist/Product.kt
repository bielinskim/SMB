package com.example.shoppinglist

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "product_table")
data class Product(@PrimaryKey(autoGenerate = true) var id: Long = 0, var name: String, var amount: Int, var price: Double, var isBought: Boolean){
}