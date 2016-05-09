require 'yaml'
require './book'
require './order'
require './reader'
require './author'

class Library
  attr_accessor :books, :orders, :readers, :authors

  def initialize(books = [], orders = [], readers = [], authors = [])
    @books, @orders, @readers, @authors = books, orders, readers, authors
  end

  def popular_reader
    popular_by(:reader).first
  end

  def popular_book
    popular_by(:book).first
  end

  def popular_author
    popular_by(:author).first
  end

  def popular_by(attr)
    popular = ordered_items_by(attr)
    popular.uniq.max_by(popular.uniq.count) { |obj| popular.count(obj) }
  end

  def popular_with_count_by(attr)
    popular = ordered_items_by(attr)
    popular_hash = {}
    popular.uniq.map { |obj| popular_hash[obj] = popular.count(obj) }
    popular_hash.sort_by(&:last).reverse.to_h
  end

  # def people_ordered(book)
  #   # popular_by(:book).select { |b| b[0].title == book.title && b[0].author == book.author }.flatten[1]
  #   popular_by(:book)[book]
  # end

  def orders_count_for(item)
    ordered_items_by(item.class.to_s.downcase).count(item)
  end

  def orders_for(item)
    ordered_items_by(item.class.to_s.downcase).select { |i| i == item }
  end

  def to_yaml
    YAML.dump ({
        readers:  @readers,
        authors:  @authors,
        books:    @books,
        orders:   @orders
      })
  end

  def save(file_name = 'library.yml')
    File.open(file_name, 'w') {|f| f.write self.to_yaml }
  end

  def self.load(file_name = 'library.yml')
    data = YAML.load File.read(file_name)
    self.new(data[:books], data[:orders], data[:readers], data[:authors])
  end

  private

    def ordered_items_by(attr)
      return @orders.map { |order| order.book.__send__(attr) } if attr.to_sym == :author
      @orders.map { |order| order.__send__(attr) }
    end
end

# readers = []
# (1..6).map { |x| readers << Reader.new("Reader #{x}", "email#{x}@email.com", "City #{1}", "str. Some", x) }

# authors = []
# (1..6).map { |x| authors << Author.new("Author #{x}", "Something") }

# books = []
# (1..6).map { |x| books << Book.new("Book #{x}", authors[rand(0..5)]) }

# orders = []
# (1..6).map { |x| orders << Order.new(books[rand(0..5)], readers[rand(0..5)], Time.now) }

# library = Library.new(books, orders, readers, authors)

# puts "The most popular reader is '#{library.popular_reader[0].name}' " \
#       "with #{library.popular_reader[1]} book(s)."

# puts "The most popular book '#{library.popular_book[0].title}' " \
#       "was taken #{library.popular_book[1]} time(s)."

# puts "The second most popular book '#{library.popular_by(:book).keys[1]}' " \
#       "with #{library.people_ordered(library.popular_by(:book).keys[1])} reader(s)."

# puts library.popular_book
# puts library.popular_by(:book)
# puts library.popular_by(:reader)
# puts library.popular_by(:author)
# puts library.orders_for(library.authors[0]).count

# puts library.popular_book.to_yaml
# puts library.popular_reader.to_yaml
# puts library.popular_author.to_yaml
# puts library.to_yaml
library = Library.load

puts "The most popular reader is '#{library.popular_reader.name}' " \
      "with #{library.orders_for(library.popular_reader).count} book(s)."

puts "The most popular book '#{library.popular_book.title}' " \
      "was taken #{library.orders_for(library.popular_book).count} time(s)."

puts "The most popular author is '#{library.popular_author.name}' " \
      "with #{library.orders_for(library.popular_author).count} book(s) sold."

# library.save("test.yml")
# (1..6).map { |x| library.orders << Order.new(library.books[rand(0..5)], library.readers[rand(0..5)], Time.now) }
# library.save

# puts library.books