class StoreController < ApplicationController

  def index
	@products = Product.find_products_for_sale
	@time = Time.now
  end
  
  def add_to_cart
    product = Product.find(params[:id]) 
    @cart = find_cart                   
    @cart.add_product(product)     
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid product #{params[:id]}")
    flash[:notice] = "Invalid product"
    redirect_to :action => 'index'	
  end
  
  def empty_cart
    session[:cart] = nil
    flash[:notice] = "Your cart is currently empty"
    redirect_to :action => 'index'
  end
  
  def pay_it
	session[:cart] = nil
    redirect_to :action => 'pay'
  end
  
private
  def find_cart
	@time = Time.now
    session[:cart] ||= Cart.new
  end
end
