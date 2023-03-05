class Api::AuthController < ApiController
  def register
    if User.find_by(email: register_params[:email]).present?
      message = 'User with email already exists'
      render json: { message: }, status: :bad_request
    else
      user = User.create(register_params)
      if user.errors&.full_messages.present?
        message = user.errors&.full_messages&.[](0)
        render json: { message: }, status: :bad_request
      else
        render json: { message: 'user was created' }, status: :created
      end
    end
  end

  def sign_in
    email = params.require('email')
    password = params.require('password')

    user = User.find_by(email:)
    if user.present?
      if user.authenticate(password)
        data = { id: user.id, first_name: user.first_name, last_name: user.last_name, email: user.email }
        token = TokenService.generate_token(data)

        render json: { message: 'login successful', data: { **data.except!(:exp), token: } }
      else
        render json: { message: 'Password is not correct' }, status: :unauthorized
      end
    else
      render json: { message: 'User with email does not exist' }, status: :not_found
    end
  end

  def register_params
    {
      email: params.require(:email),
      first_name: params.require(:first_name),
      last_name: params.require(:last_name),
      password: params.require(:password)
    }
  end
end

