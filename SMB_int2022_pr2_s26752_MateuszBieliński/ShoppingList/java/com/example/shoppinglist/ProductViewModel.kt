package com.example.shoppinglist

import android.app.Application
import android.content.Context
import android.util.Log
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData

class ProductViewModel(application: Application, context: Context) : AndroidViewModel(application) {
    private val repository: ProductRepository
    val allProducts: LiveData<List<Product>>
    val productToEdit: LiveData<Product>?
    init {
        val productDao = ProductDB.getDatabase(context).productDao()
        repository = ProductRepository(productDao)
        allProducts = repository.allProducts
        productToEdit = null
    }
    fun insert(product: Product) :Long = repository.insert(product)
    fun update(product: Product) = repository.update(product)
    fun delete(product: Product) = repository.delete(product)
    fun deleteAll() = repository.deleteAll()
}