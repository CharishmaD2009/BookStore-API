class Api::V1::BooksController < ApplicationController
  skip_before_action :authenticate_request

  def index
    books = Book.includes(:category)
                .where(published: true)
                .order(:id)

    if params[:category].present?
      books = books.joins(:category)
                   .where(categories: { name: params[:category] })
    end

    if params[:title].present?
      books = books.where("LOWER(title) LIKE ?", "%#{params[:title].downcase}%")
    end

    if params[:isbn].present?
      books = books.where(isbn: params[:isbn])
    end

    if params[:min_price].present?
      books = books.where("price >= ?", params[:min_price])
    end

    if params[:max_price].present?
      books = books.where("price <= ?", params[:max_price])
    end

    render json: books.as_json(
      only: [:id, :title, :author, :isbn, :price, :stock, :published],
      include: {
        category: {
          only: [:id, :name]
        }
      }
    ), status: :ok
  end

  def show
    book = Book.includes(:category)
               .where(published: true)
               .find_by(id: params[:id])

    if book
      render json: book.as_json(
        only: [
          :id,
          :title,
          :author,
          :isbn,
          :price,
          :description,
          :stock,
          :cover_url,
          :published
        ],
        include: {
          category: {
            only: [:id, :name]
          }
        }
      ), status: :ok
    else
      render json: {
        error: "Book not found"
      }, status: :not_found
    end
  end
end