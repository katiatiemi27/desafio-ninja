module ApplicationManager
  class Destroyer
    attr_accessor :id

    def destroy
      ActiveRecord::Base.transaction { execute_destruction }
    end

    private

    def execute_destruction
      raise NotImplementedError
    end

    def initialize(id)
      @id = id
    end
  end
end