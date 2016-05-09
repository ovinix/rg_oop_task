class Reader
  attr_accessor :name, :email, :city, :street, :house

  def initialize(name, email, city, street, house)
    @name, @email, @city, @street, @house = name, email, city, street, house
  end

  def to_s
    "#{name} <#{email}>"
  end

  def to_yaml
    YAML.dump ({
        name: @name,
        email: @email,
        city: @city,
        street: @street,
        house: @house
      })
  end
end