module Exceptions
  class Base < StandardError
    CODE = 500
    MESSAGE = 'serviço indisponível'.freeze

    def message
      self.class::MESSAGE
    end

    def code
      self.class::CODE
    end

    def initialize(options = {})
      @options = options
    end
  end

  class NotSameDay < Base
    CODE = :bad_request
    MESSAGE = 'A reunião precisa iniciar e finalizar no mesmo dia'.freeze
  end

  class NotComercialHour < Base
    CODE = :bad_request
    MESSAGE = 'A reunião precisa iniciar e finalizar no horário comercial: 09 até às 18 horas'.freeze
  end

  class NonExistentRoom < Base
    CODE = :bad_request
    MESSAGE = 'A sala escolhida não existe'.freeze
  end

  class RoomNotAvailable < Base
    CODE = :bad_request
    MESSAGE = 'A sala escolhida não está disponível'.freeze
  end

  class InvalidHour < Base
    CODE = :bad_request
    MESSAGE = 'Hora de início deve ser menor que a hora do fim'.freeze
  end
end
