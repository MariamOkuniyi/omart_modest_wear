# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
products = [
  ["Everyday Navy Abaya", "Abayas", "Comfortable navy abaya with a relaxed fit for everyday wear.", 69.99, 12],
  ["Embroidered Occasion Abaya", "Abayas", "Elegant abaya with delicate embroidery for special occasions.", 109.99, 8],
  ["Premium Chiffon Hijab", "Hijabs", "Lightweight chiffon hijab with a soft flowing finish.", 19.99, 30],
  ["Cotton Jersey Hijab", "Hijabs", "Stretchy breathable jersey hijab for comfortable daily styling.", 24.99, 25],
  ["Floral Maxi Dress", "Modest Dresses", "Long-sleeved floral maxi dress with a loose modest silhouette.", 64.99, 15],
  ["Pleated Evening Dress", "Modest Dresses", "Full-length pleated dress suitable for formal occasions.", 89.99, 10],
  ["Linen Tunic and Trouser Set", "Two-Piece Sets", "Relaxed linen tunic paired with matching wide-leg trousers.", 79.99, 14],
  ["Casual Co-ord Set", "Two-Piece Sets", "Comfortable matching top and trousers for everyday modest fashion.", 59.99, 18],
  ["Magnetic Hijab Pins", "Accessories", "Set of secure magnetic pins that hold hijabs without damaging fabric.", 12.99, 40]
]

products.each do |name, category_name, description, price, stock|
  category = Category.find_by!(name: category_name)

  Product.find_or_create_by!(name: name) do |product|
    product.category = category
    product.description = description
    product.price = price
    product.stock_quantity = stock
    product.on_sale = false
  end
end

puts "Total products: #{Product.count}"
# Canadian provinces and territories
provinces = {
  "AB" => ["Alberta", 0.05],
  "BC" => ["British Columbia", 0.12],
  "MB" => ["Manitoba", 0.12],
  "NB" => ["New Brunswick", 0.15],
  "NL" => ["Newfoundland and Labrador", 0.15],
  "NT" => ["Northwest Territories", 0.05],
  "NS" => ["Nova Scotia", 0.14],
  "NU" => ["Nunavut", 0.05],
  "ON" => ["Ontario", 0.13],
  "PE" => ["Prince Edward Island", 0.15],
  "QC" => ["Quebec", 0.14975],
  "SK" => ["Saskatchewan", 0.11],
  "YT" => ["Yukon", 0.05]
}

provinces.each do |code, (name, tax_rate)|
  province = Province.find_or_initialize_by(code: code)
  province.update!(name: name, tax_rate: tax_rate)
end

puts "13 Canadian provinces and territories seeded successfully."