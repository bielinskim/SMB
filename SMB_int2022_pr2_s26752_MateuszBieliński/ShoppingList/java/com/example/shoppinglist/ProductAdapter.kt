package com.example.shoppinglist

import android.content.Context
import android.content.Intent
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.recyclerview.widget.RecyclerView

class ProductAdapter(private val context: Context, val productViewModel: ProductViewModel)
    : RecyclerView.Adapter<ProductAdapter.ViewHolder>(){

    private var products = emptyList<Product>()

    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val productNameView: TextView = view.findViewById(R.id.productName)
        val productAmountView: TextView = view.findViewById(R.id.productAmount)
        val productPriceView: TextView = view.findViewById(R.id.productPrice)
        val productIsBoughtView: CheckBox = view.findViewById(R.id.productIsBought)
        val productEditView: ImageView = view.findViewById(R.id.productEdit)
        val productDeleteView: ImageView = view.findViewById(R.id.productDelete)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.shopping_list_item, parent, false)

        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val product = products[position]

        holder.productNameView.text = product.name
        holder.productAmountView.text = product.amount.toString()
        holder.productPriceView.text = product.price.toString()
        holder.productIsBoughtView.isChecked = product.isBought

        holder.productEditView.setOnClickListener {
            val intent = Intent(context, ProductFormActivity::class.java)
            intent.putExtra("productId", product.id.toInt())
            intent.putExtra("productName", product.name)
            intent.putExtra("productAmount", product.amount)
            intent.putExtra("productPrice", product.price)
            intent.putExtra("productIsBought", product.isBought)
            context.startActivity(intent)
        }

        holder.productDeleteView.setOnClickListener {
            productViewModel.delete(product)
            Toast.makeText(context,"Deleted:${product.id}",
                Toast.LENGTH_SHORT).show()
        }
    }
    internal fun setProducts(newProducts: List<Product>){
        products = newProducts
        notifyDataSetChanged()
    }
    override fun getItemCount(): Int = products.size
}