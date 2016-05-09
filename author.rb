class Author
  attr_accessor :name, :biography

  def initialize(name, biography)
    @name, @biography = name, biography
  end

  def to_s
    @name
  end

  def to_yaml
    YAML.dump ({
        name: @name,
        biography: @biography
      })
  end
end