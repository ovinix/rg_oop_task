class Book
  attr_accessor :title, :author

  def initialize(title, author)
    @title, @author = title, author
  end

  def to_s
    "#{title} by #{author}"
  end

  def to_yaml
    YAML.dump ({
        title: @title,
        author: @author
      })
  end
end