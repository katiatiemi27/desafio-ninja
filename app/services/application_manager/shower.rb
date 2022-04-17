module ApplicationManager
  class Shower
    attr_accessor :id

    def build
      instance
    end

    private

    def instance
      raise NotImplementedError
    end

    def initialize(id)
      @id = id
    end
  end
end
