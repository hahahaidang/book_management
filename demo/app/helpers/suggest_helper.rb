module SuggestHelper

  def halfInsertBook(name, link, description, price, quantity)
    self.book_name = name
    self.book_link = link
    self.book_description = description
    self.book_price = price
    self.book_quantity = quantity
    self.save
  end




end
