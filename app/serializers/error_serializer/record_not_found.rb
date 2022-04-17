module ErrorSerializer
  class RecordNotFound < ErrorSerializer::Base
    attribute(:message) { object }
  end
end
