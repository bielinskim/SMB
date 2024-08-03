package com.example.shoppinglist

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.CheckBox
import android.widget.TextView

class ProductFormActivity : AppCompatActivity() {
    private lateinit var productViewModel: ProductViewModel
    private lateinit var productNameInput: TextView
    private lateinit var productAmountInput: TextView
    private lateinit var productPriceInput: TextView
    private lateinit var productIsBoughtInput: CheckBox

    var productId: Int? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_product_form)
        productViewModel = ProductViewModel(application, this)

        productNameInput = findViewById(R.id.productNameInput)
        productAmountInput = findViewById(R.id.productAmountInput)
        productPriceInput = findViewById(R.id.productPriceInput)
        productIsBoughtInput = findViewById(R.id.productIsBoughtInput)


        if(intent.extras != null) {
            productId = intent.extras!!.getInt("productId")

            if(productId != null) {
                productNameInput.text = intent.extras!!.getString("productName")
                productAmountInput.text = intent.extras!!.getInt("productAmount").toString()
                productPriceInput.text = intent.extras!!.getDouble("productPrice").toString()
                productIsBoughtInput.isChecked = intent.extras!!.getBoolean("productIsBought")
            }
        }

        val productSaveButton: Button = findViewById(R.id.productSaveButton)

        productSaveButton.setOnClickListener {

            val newProductName :String = productNameInput.text.toString()
            val newProductAmount :Int = productAmountInput.text.toString().toInt()
            val newProductPrice :Double = productPriceInput.text.toString().toDouble()
            val newProductIsBought :Boolean = productIsBoughtInput.isChecked

            if(productId != null) {
                val newProductId = productId!!.toLong()

                productViewModel.update(Product(newProductId, newProductName, newProductAmount, newProductPrice, newProductIsBought))
            } else {

                val newProductId = productViewModel.insert(Product(0, newProductName, newProductAmount, newProductPrice, newProductIsBought))


                val broadcastIntent = Intent("com.example.shoppinglist.ADD_PRODUCT")
                broadcastIntent.putExtra("productId", newProductId.toInt())
                broadcastIntent.putExtra("productName", newProductName)
                broadcastIntent.putExtra("productAmount", newProductAmount)
                broadcastIntent.putExtra("productPrice", newProductPrice)
                broadcastIntent.putExtra("productIsBought", newProductIsBought)
                sendBroadcast(broadcastIntent, "com.example.shoppinglistnotification.RECEIVE_INTENT")
            }
            val intent = Intent(this, MainActivity::class.java)
            startActivity(intent)
        }

    }
}