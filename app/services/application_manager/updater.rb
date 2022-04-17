module ApplicationManager
  class Updater
    attr_accessor :id

    def update(with_transaction = true)
      if with_transaction
        ActiveRecord::Base.transaction { execute_update }
      else
        execute_update
      end
    end

    private

    def execute_update
      raise NotImplementedError
    end

    def initialize(id)
      @id = id
    end
  end
end
