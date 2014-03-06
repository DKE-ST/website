class Bible
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :class, :year, :semester
  validates :class, presence: true
  validates :year, presence: true
  validates :semester, presence: true
  
  def initialize(attributes = {})
    if attributes.class == ActionController::Parameters || attributes.class == Hash
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
  end
  
  
end
