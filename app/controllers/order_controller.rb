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
            quantity: params[:quantity],
            total: params[:item_price].to_i * params[:quantity].to_i
        )
        current_user.orders << @order 
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


end 