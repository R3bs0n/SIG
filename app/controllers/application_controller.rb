class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern unless Rails.env.test?

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def append_info_to_payload(payload)
    super
    payload[:user_id] = current_user&.id
  end

  def user_not_authorized
    redirect_back fallback_location: root_path, alert: "Voce nao tem permissao para executar esta acao."
  end
end
