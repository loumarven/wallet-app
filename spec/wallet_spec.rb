require 'wallet'

RSpec.describe Wallet do
  describe '#new' do
    it 'initializes an instance of Wallet' do
      my_wallet = Wallet.new

      expect(my_wallet).to be_an_instance_of(Wallet)
      expect(my_wallet).not_to be_nil
    end

    context 'when a wallet is initialized without an amount' do
      it 'initializes the balance to 0' do
        my_wallet = Wallet.new

        expect(my_wallet.balance).to eq(0)
      end
    end

    context 'when it is initialized with an amount' do
      before(:each) { my_wallet = Wallet.new(100.50) }

      it 'accepts a float as the amount' do
        expect(my_wallet).to be_truthy
        expect(my_wallet.balance).to be_a(Float)
      end

      it 'initializes the balance to the amount given' do
        expect(my_wallet.balance).to eq(100.50)
      end
    end

    context 'when it is initialized with an incorrect value' do
      it 'raises an invalid value ArgumentError' do
        #TODO
        my_wallet = Wallet.new('abc')
      end
    end
  end
end
