class AddressesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(address_params)
      redirect_to edit_addresses_path,
                  notice: "Your shipping address has been saved successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.require(:user).permit(
      :full_name,
      :street_address,
      :city,
      :postal_code,
      :province_id
    )
  end
end