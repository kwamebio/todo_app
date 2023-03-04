class TokenService
    SECRET = 'my special secret'
  
    def self.generate_token(payload, exp = 4.hours.from_now.to_i)
      payload[:exp] = exp
      return JWT.encode(payload, SECRET)
    end
  
    def self.decode(token)
      return JWT.decode(token, SECRET, true)
    end
  end
  