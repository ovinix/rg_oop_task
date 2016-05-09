class Order
  attr_accessor :book, :reader, :date

  def initialize(book, reader, date)
    @book, @reader, @date = book, reader, date
  end

  def to_yaml
    YAML.dump ({
        book: @book,
        reader: @reader,
        date: @date
      })
  end
end