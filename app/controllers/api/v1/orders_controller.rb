class Api::V1::OrdersController < ApplicationController

  def create
    cart = @current_user.cart

    if cart.nil? || cart.cart_items.empty?
      return render json: {
        error: "Cart is empty"
      }, status: :unprocessable_entity
    end

    unless params[:shipping_address].present?
      return render json: {
        error: "Shipping address is required"
      }, status: :unprocessable_entity
    end

    order = Order.create!(
      user: @current_user,
      total_amount: 0,
      status: :placed,
      shipping_address: params[:shipping_address]
    )

    total_amount = 0

    cart.cart_items.includes(:book).each do |item|

      if item.book.stock < item.quantity
        order.destroy

        return render json: {
          error: "#{item.book.title} does not have enough stock"
        }, status: :unprocessable_entity
      end

      OrderItem.create!(
        order: order,
        book: item.book,
        quantity: item.quantity,
        price: item.book.price
      )

      item.book.update!(
        stock: item.book.stock - item.quantity
      )

      total_amount += item.book.price * item.quantity
    end

    order.update!(
      total_amount: total_amount
    )

    cart.cart_items.destroy_all

    render json: {
      message: "Order placed successfully",
      order_id: order.id,
      total_amount: order.total_amount,
      status: order.status
    }, status: :created
  end

  def index
    orders = @current_user.orders.includes(order_items: :book)

    render json: orders.as_json(
      only: [:id, :status, :shipping_address, :total_amount, :created_at],
      include: {
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

  def show
    order = @current_user.orders.includes(order_items: :book).find_by(id: params[:id])

    unless order
      return render json: {
        error: "Order not found"
      }, status: :not_found
    end

    render json: order.as_json(
      only: [:id, :status, :shipping_address, :total_amount, :created_at],
      include: {
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

end