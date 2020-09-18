require 'wallet'

RSpec.describe Wallet do
  describe '#new' do
    it 'initializes an instance of Wallet' do
      my_wallet = Wallet.new

      expect(my_wallet).to be_an_instance_of(Wallet)
      expect(my_wallet).to be_truthy
    end

    context 'when a wallet is initialized without an amount' do
      it 'initializes the balance to 0' do
        my_wallet = Wallet.new

        expect(my_wallet.balance).to eq(0)
      end
    end

    context 'when it is initialized with a valid amount' do
      before(:each) { @my_wallet = Wallet.new(100.50) }

      it 'accepts a float as the amount' do
        expect(@my_wallet).to be_truthy
        expect(@my_wallet.balance).to be_a(Float)
      end

      it 'initializes the balance to the amount given' do
        expect(@my_wallet.balance).to eq(100.50)
      end

      it 'casts an integer amount to float' do
        my_wallet = Wallet.new(100)
        expect(my_wallet.balance).to be_a(Float)
      end
    end


    context 'when it is initialized with an invalid value' do
      it 'raises an invalid value error for negative amount' do
        expect{ Wallet.new -100 }.to raise_error(/Invalid value -100 for #initialize/)
      end

      it 'raises an invalid value error for incorrect type' do
        expect{ Wallet.new 'abc' }.to raise_error(/Invalid value abc for #initialize/)
      end
    end
  end

  describe '#add_money' do
    before(:each) { @my_wallet = Wallet.new(500) }

    context 'when a valid amount is added to the wallet' do
      it 'adds the amount to the wallet balance' do
        @my_wallet.add_money(50)
        expect(@my_wallet.balance).to eq(550.00)
      end
    end

    context 'when an invalid amount is added to the wallet' do
      it 'raises an invalid value error for negative amount' do
        expect{ @my_wallet.add_money(-20) }.to raise_error(/Invalid value -20 for #add_money/)
        expect(@my_wallet.balance).to eq(500.00)
      end

      it 'raises an invalid value error for incorrect type' do
        expect{ @my_wallet.add_money('receipt') }.to raise_error(/Invalid value receipt for #add_money/)
        expect(@my_wallet.balance).to eq(500.00)
      end
    end
  end

  describe '#spend_money' do
    before(:each) { @my_wallet = Wallet.new(500) }

    context 'when there is enough wallet balance to spend' do
      it 'deducts the amount spent from the wallet balance' do
        @my_wallet.spend_money(100.50)
        expect(@my_wallet.balance).to eq(399.50)
      end
    end

    context 'when there is not enough wallet balance to spend' do
      it 'raises an insufficient balance error' do
        expect{ @my_wallet.spend_money(600) }.to raise_error(/Insufficient funds!/)
        expect(@my_wallet.balance).to eq(500.00)
      end
    end

    context 'when attempting to spend an invalid amount' do
      it 'raises an invalid value error for negative amount' do
        expect{ @my_wallet.spend_money(-100) }.to raise_error(/Invalid value -100 for #spend_money/)
      end

      it 'raises an invalid value error for incorrect type' do
        expect{ @my_wallet.spend_money('Shopee points') }.to raise_error(/Invalid value Shopee points for #spend_money/)
      end
    end
  end
end
