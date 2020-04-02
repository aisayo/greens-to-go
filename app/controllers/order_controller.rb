class OrderController < ApplicationController

    get '/orders/new' do 
        if logged_in?
            erb :'/orders/new'
        else 
            flash[:alert] = "Please login to place an order"
            redirect "/users/login"
        end 
    end 

    post '/orders' do 
        @order = Order.create(
            order_date: params[:order_date], 
            food_item: params[:food_item], 
            quantity: params[:quantity]
        )
        @order.user = current_user
        @order.total = params[:item_price] * @order.quantity
        redirect "/orders/#{@order.id}"
    end 

    get '/orders/:id' do 
        @order = Order.find(params[:id])
        erb :'/orders/show'
    end 

    get '/orders' do 
        @orders = Order.all  
        erb :'/orders/index'
    end 

    get '/orders/:id/edit' do 
        @order = Order.find(params[:id])
        erb :'/orders/edit'
    end 

    post '/orders/:id' do 
        @order = Order.find(params[:id])
        @order.update(
            address: params[:address], 
            item: params[:item], 
            item_price: params[:item_price], 
            total: params[:total]
        )
        redirect "/orders/#{@order.id}"
    end 

    delete '/orders/:id' do
        @order = Order.find(params[:id])
        @order.delete
        redirect '/orders'
    end 

    get '/about' do 
        "this is an about page"
    end 

    get '/menu' do 
        @menu_items = MenuItem.all
        erb :'/menu_items/show'
    end 

end 