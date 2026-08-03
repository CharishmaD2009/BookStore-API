class Api::V1::Admin::BooksController < ApplicationController
  before_action :authorize_admin

  def create
    category = Category.find_by(id: params[:category_id])

    unless category
      return render json: {
        error: "Category not found"
      }, status: :not_found
    end

    book = Book.new(book_params)
    book.category = category

    if book.save
      render json: {
        message: "Book created successfully",
        book: book
      }, status: :created
    else
      render json: {
        errors: book.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    book = Book.find_by(id: params[:id])

    unless book
      return render json: {
        error: "Book not found"
      }, status: :not_found
    end

    if book.update(book_params)
      render json: {
        message: "Book updated successfully",
        book: book
      }, status: :ok
    else
      render json: {
        errors: book.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    book = Book.find_by(id: params[:id])

    unless book
      return render json: {
        error: "Book not found"
      }, status: :not_found
    end

    book.destroy

    render json: {
      message: "Book deleted successfully"
    }, status: :ok
  end

  private

  def book_params
    params.permit(
      :title,
      :author,
      :isbn,
      :price,
      :description,
      :stock,
      :cover_url,
      :published
    )
  end
end