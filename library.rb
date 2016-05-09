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

  def method_missing (meth, *args, &block)
    if meth.to_s =~ /^popular_(\w+)$/
      popular_by($1.to_sym).first rescue Library::NoAttributeError
    else
      super
    end
  end

  private

    def ordered_items_by(attr)
      return @orders.map { |order| order.book.__send__(attr) } if attr.to_sym == :author
      @orders.map { |order| order.__send__(attr) }
    end
end

library = Library.load

puts "The most popular reader is '#{library.popular_reader}' " \
      "with #{library.orders_count_for(library.popular_reader)} book(s)."

puts "The most popular book '#{library.popular_book}' " \
      "was taken #{library.orders_for(library.popular_book).count} time(s)."

puts "The most popular author is '#{library.popular_author.name}' " \
      "with #{library.orders_for(library.popular_author).count} book(s) sold."

library.save("test.yml")