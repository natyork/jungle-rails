require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @category = Category.create!
      @product1 = Product.create! ({
        name: "Garbage",
        price: 1234,
        quantity: 10,
        category: @category
      })
      @product2 = Product.create! ({
        name: "Garbage2",
        price: 1234,
        quantity: 10,
        category: @category
      })
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(
        email: "foo@bar.com",
        total_cents: 1000,
        stripe_charge_id: 42 # returned by stripe
      )

      quantity = 2

      if product = Product.find_by(id: @product1.id)
        @order.line_items.new(
          product: product,
          quantity: quantity,
          item_price: product.price,
          total_price: product.price * quantity
        )
      end
      # ...
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eql 8
      expect(@product2.quantity).to eql 10

    end
    # pending test 2
    xit 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
    end
  end
end






















