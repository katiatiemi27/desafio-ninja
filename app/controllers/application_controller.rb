class ApplicationController < ActionController::Base
  rescue_from(StandardError) { |e| error!(Exceptions::Base.new, :internal_server_error, nil, e)}
  rescue_from(ActiveRecord::RecordNotFound) { |e| error!(e, :bad_request, ErrorSerializer::RecordNotFound) }

  def error!(error, code, serializer = nil)
    original_error ||= error

    serializer ||= ErrorSerializer::Base
    render json: error, status: code, serializer: serializer
  end
end
