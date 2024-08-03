package com.example.shoppinglist

import androidx.lifecycle.LiveData

class ProductRepository(private val productDao: ProductDao) {
    val allProducts: LiveData<List<Product>> = productDao.getProducts()
    fun insert(product: Product) :Long {
        return productDao.insert(product)
    }
    fun update(product: Product){
        productDao.update(product)
    }
    fun delete(product: Product){
        productDao.delete(product)
    }
    fun deleteAll(){
        productDao.deleteAll()
    }

    fun deleteById(idd: Long){
        productDao.deleteById(idd)
    }
}