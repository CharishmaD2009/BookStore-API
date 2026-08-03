class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_request, only: [:register, :login]

  def register
    user = User.new(user_params)

    if user.save
      Cart.create!(user: user)

      render json: {
        message: "User registered successfully",
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          role: user.role,
          active: user.active
        }
      }, status: :created
    else
      render json: {
        errors: user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JwtService.encode(user_id: user.id)

      render json: {
        message: "Login successful",
        token: token,
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          role: user.role,
          active: user.active
        }
      }, status: :ok
    else
      render json: {
        error: "Invalid email or password"
      }, status: :unauthorized
    end
  end

  def logout
    render json: {
      message: "Logged out successfully"
    }, status: :ok
  end

  def me
    render json: {
      user: {
        id: @current_user.id,
        name: @current_user.name,
        email: @current_user.email,
        role: @current_user.role,
        active: @current_user.active
      }
    }, status: :ok
  end

  def update_profile
    if @current_user.update(user_params)
      render json: {
        message: "Profile updated successfully",
        user: {
          id: @current_user.id,
          name: @current_user.name,
          email: @current_user.email,
          role: @current_user.role,
          active: @current_user.active
        }
      }, status: :ok
    else
      render json: {
        errors: @current_user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end