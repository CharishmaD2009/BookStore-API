class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers["Authorization"]

    token = header.split(" ").last if header

    decoded = JwtService.decode(token)

    if decoded
      @current_user = User.find_by(id: decoded["user_id"])

      unless @current_user
        render json: { error: "User not found" }, status: :unauthorized
      end
    else
      render json: { error: "Invalid or missing token" }, status: :unauthorized
    end
  end

  def authorize_admin
    unless @current_user.role == "admin"
      render json: { error: "Access denied. Admin only." }, status: :forbidden
    end
  end
end