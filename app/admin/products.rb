ActiveAdmin.register Product do

  # Prevent ActiveAdmin from generating unsupported image attachment filters.
  remove_filter :image_attachment
  remove_filter :image_blob
  # Allow administrators to manage product details and upload images.
  permit_params :category_id, :name, :description,
                :price, :stock_quantity, :on_sale, :image

  form html: { multipart: true } do |f|
    f.inputs "Product Details" do
      f.input :category
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :on_sale

      # Upload a product image.
      f.input :image, as: :file,
                      hint: "Upload a product image (JPG or PNG)"
    end

    f.actions
  end
end