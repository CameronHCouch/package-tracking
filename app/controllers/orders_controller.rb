class OrdersController < ApplicationController
    before_action :ensure_logged_in

    def index
        @orders = Order.all
    end

    def show
        @order = Order.find(params[:id])
    end
    
    def new
        @order = Order.new
    end

    def create
        @order = Order.new(order_params)
        @order.orderer_id = current_user.id
        @order.vendor_id = params[:order][:vendor].id
        @order.delivery_status_id = DeliveryStatus.new(normal_time: 3);
        if @order.save
            redirect_to order_url(@order)
        else
            flash.now[:errors] = @order.errors.full_messages
            render :new
        end
    end

    private

    def order_params
        params.require(:order).permit(:order_number, :tracking_number, :address)
    end
end