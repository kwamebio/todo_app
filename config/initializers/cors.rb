Rails.application.config.middleware.insert_before 0, Rack::Cors, debug: false, logger: (lambda {
    Rails.logger
  }) do
    allow do
      origins ['*']
  
      resource '/api/*',
               headers: :any,
               methods: %i[get post delete put patch]
    end
  end
  