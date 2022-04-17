module ErrorSerializer
  class Base < ActiveModel::Serializer
    type :error
    attribute(:tag) { object.class.name }
    attribute(:message) { object.message }
  end
end
