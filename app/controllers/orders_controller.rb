class OrdersController < ApplicationController
  before_action :ensure_logged_in

  def index
    # debugger
    @orders = Order.all.where(delivered: false)
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id

    vendor = Vendor.find_by(name: params[:order][:vendor])
    unless vendor
      vendor = Vendor.create!(name: params[:order][:vendor])
    end
    @order.vendor_id = vendor.id
    @order.delivery_status_id = DeliveryStatus.create!(normal_time: 3).id;

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