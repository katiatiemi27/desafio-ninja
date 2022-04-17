module ApplicationManager
  class Lister
    
    def build
      filter
    end

    def filter
      raise NotImplementedError
    end

    private

    def initialize(filters = { })
      @filters = filters.with_indifferent_access
    end
  end
end
