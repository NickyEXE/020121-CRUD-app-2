class Book < ApplicationRecord
  before_save :get_image_url

  def get_image_url
    request_url = URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{self.title}")
    response = `curl "#{request_url}"`
    json = JSON.parse(response)
    book = json["items"].find{|book| book["volumeInfo"]["imageLinks"]}
    self.image_url = book["volumeInfo"]["imageLinks"]["thumbnail"]
  end

  def update_image_url
    get_image_url
    self.save
  end


end
