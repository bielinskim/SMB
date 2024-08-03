package com.example.shoppinglist


import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView

class MainActivity : AppCompatActivity() {
    private lateinit var productViewModel: ProductViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        productViewModel = ProductViewModel(application, this)

        val shoppingListRecyclerView: RecyclerView = findViewById(R.id.shoppingListRecyclerView)
        shoppingListRecyclerView.layoutManager =  LinearLayoutManager(this)

        val productAdapter = ProductAdapter(this, productViewModel)
        shoppingListRecyclerView.adapter = productAdapter

        productViewModel.allProducts.observe(this, Observer { products ->
            products?.let {
                productAdapter.setProducts(products)
            }
        })

        val productAddButton: Button = findViewById(R.id.productAddButton)

        productAddButton.setOnClickListener {
            val intent = Intent(this, ProductFormActivity::class.java)
            startActivity(intent)
        }
    }
}