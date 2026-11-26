require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "rejects unsupported image file types" do
  product = Product.first || Product.new

  product.image.attach(
    io: StringIO.new("not an image"),
    filename: "test.txt",
    content_type: "text/plain"
  )

  assert_not product.valid?
  assert_includes product.errors[:image],
                  "must be a JPG, PNG, or WebP image"
  end

  test "rejects images larger than 5 MB" do
  product = Product.first || Product.new

  product.image.attach(
    io: StringIO.new("a" * (5.megabytes + 1)),
    filename: "large_image.jpg",
    content_type: "image/jpeg"
  )

  assert_not product.valid?
  assert_includes product.errors[:image],
                  "must be smaller than 5 MB"
  end
end
