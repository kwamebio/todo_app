class Api::TestController < ApiController

    def index
        render json: {message: "Api works"}
    end
end
