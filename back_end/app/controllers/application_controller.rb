class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def verified_request?
    token = request.headers['X-CSRF-TOKEN']
    decoded_token = URI.decode(token) if token.present?
    super || valid_authenticity_token?(session, decoded_token)
  end
end
