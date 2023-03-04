class ApiController < ActionController::Base
    skip_before_action :verify_authenticity_token
  
    rescue_from StandardError, with: :handle_api_error
  
    def handle_api_error(e)  
      case e
      when ActionController::ParameterMissing
        return render json: { message: param_missing_message(e.message) || 'Invalid Params' },
                      status: :bad_request
      when JWT::ExpiredSignature
        return render json: { message: 'Token has expired' }, status: :unauthorized
      when JWT::DecodeError
        return render json: { message: 'Token is invalid' }, status: :unauthorized
      when ActiveRecord::RecordNotFound
        return render json: { message: e.message || 'Resource not found' }, status: :not_found
      else
        return render json: { message: e.message }, status: :internal_server_error
      end
    end
  
    def param_missing_message(message)
      if message.match?(/empty: password/)
        'Password is missing'
      elsif message.match?(/empty: email/)
        'Email is missing'
      elsif message.match?(/empty: first_name/)
        'First name is missing'
      elsif message.match?(/empty: last_name/)
        'Last name is missing'
      elsif message.match?(/empty: status/)
        'status is missing'
      elsif message.match?(/empty: name/)
        'name is missing'
      end
    end
  
    def authenticate
      token = request.headers['Authorization']&.gsub('Bearer ', '')
      return render json: { message: 'No token in the header' }, status: :unauthorized if token.blank?
  
      user_data = TokenService.decode(token)
      @user = User.find(user_data.first['id'])
    end
  end