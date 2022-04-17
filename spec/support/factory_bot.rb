# frozen_string_literal: true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot::SyntaxRunner.class_eval do
  include RSpec::Mocks::ExampleMethods

  # FactoryBot doesn't allow yet to add a helper that can be used in factories
  # While the fixture_file_upload helper is reasonable to be used there:
  #
  # https://github.com/thoughtbot/factory_bot/issues/564#issuecomment-389491577
  def fixture_file_upload(*args, **kwargs)
    Rack::Test::UploadedFile.new(*args, **kwargs)
  end
end
