class Api::V1::CartController < ApplicationController

  def show
    cart = @current_user.cart || Cart.create!(user: @current_user)

    render json: {
      id: cart.id,
      items: cart.cart_items.includes(:book).map do |item|
        {
          id: item.id,
          quantity: item.quantity,
          book: {
            id: item.book.id,
            title: item.book.title,
            author: item.book.author,
            price: item.book.price
          }
        }
      end
    }, status: :ok
  end

  def add_item
    cart = @current_user.cart || Cart.create!(user: @current_user)

    book = Book.find_by(id: params[:book_id])

    unless book
      return render json: {
        error: "Book not found"
      }, status: :not_found
    end

    if book.stock <= 0
      return render json: {
        error: "Book is out of stock"
      }, status: :unprocessable_entity
    end

    cart_item = cart.cart_items.find_by(book_id: book.id)

    if cart_item
      cart_item.quantity += params[:quantity].to_i
      cart_item.save!
    else
      cart_item = cart.cart_items.create!(
        book: book,
        quantity: params[:quantity]
      )
    end

    render json: {
      message: "Book added to cart successfully",
      cart_item: {
        id: cart_item.id,
        quantity: cart_item.quantity,
        book: {
          id: book.id,
          title: book.title,
          author: book.author,
          price: book.price
        }
      }
    }, status: :created
  end

  def update_item
    cart_item = CartItem.find_by(id: params[:id])

    unless cart_item
      return render json: {
        error: "Cart item not found"
      }, status: :not_found
    end

    unless cart_item.cart.user == @current_user
      return render json: {
        error: "Unauthorized"
      }, status: :unauthorized
    end

    cart_item.update!(quantity: params[:quantity])

    render json: {
      message: "Cart updated successfully",
      cart_item: {
        id: cart_item.id,
        quantity: cart_item.quantity
      }
    }, status: :ok
  end

  def remove_item
    cart_item = CartItem.find_by(id: params[:id])

    unless cart_item
      return render json: {
        error: "Cart item not found"
      }, status: :not_found
    end

    unless cart_item.cart.user == @current_user
      return render json: {
        error: "Unauthorized"
      }, status: :unauthorized
    end

    cart_item.destroy

    render json: {
      message: "Item removed from cart successfully"
    }, status: :ok
  end

end