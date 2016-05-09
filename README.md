# Library
- Book: title, author
- Order: book, reader, date
- Reader: name, email, city, street, house
- Author: name, biography
- Library: books, orders, readers, authors

Write program that determines:
- Who often takes the book
- What is the most popular book
- How many people ordered one of the three most popular books
- Save all Library data to file(s)
- Get all Library data from file(s)

# Result
```sh
~/rg_oop_task$ ruby library.rb
The most popular reader is 'Ann <ann@email.com>' with 4 book(s).
The most popular book 'Game Of Thrones by George Martin' was taken 5 time(s).
The most popular author is 'Mikhail Bulgakov' with 6 book(s) sold.
```