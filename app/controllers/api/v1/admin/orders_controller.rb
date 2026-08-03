class Api::V1::Admin::OrdersController < ApplicationController
  before_action :authorize_admin

  def index
    orders = Order.includes(:user, order_items: :book)

    render json: orders.as_json(
      only: [:id, :status, :shipping_address, :total_amount, :created_at],
      include: {
        user: {
          only: [:id, :name, :email]
        },
        order_items: {
          only: [:id, :quantity, :price],
          include: {
            book: {
              only: [:id, :title, :author]
            }
          }
        }
      }
    ), status: :ok
  end

  def update
    order = Order.find_by(id: params[:id])

    unless order
      return render json: {
        error: "Order not found"
      }, status: :not_found
    end

    unless Order.statuses.keys.include?(params[:status])
      return render json: {
        error: "Invalid status"
      }, status: :unprocessable_entity
    end

    order.update!(status: params[:status])

    render json: {
      message: "Order status updated successfully",
      order: order
    }, status: :ok
  end
end