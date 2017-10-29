# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      @message = e.message
      render 'errors/show.json', status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response
  end

  private

    def unprocessable_entity_response(e)
      @message = e.message
      render 'errors/show.json', status: :unprocessable_entity
    end
end
