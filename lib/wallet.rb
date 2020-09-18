class Wallet
  attr_reader :balance

  def initialize(balance=0)
    validate_param(balance, __method__)
    @balance = Float(balance)
  end

  def add_money(amount)
    validate_param(amount, __method__)
    @balance += Float(amount)
  end

  def spend_money(amount)
    validate_param(amount, __method__)
    raise_insufficient_balance(amount) if insufficient_balance?(amount)
    @balance -= Float(amount)
  end

  private
  def insufficient_balance?(amount)
    @balance - amount < 0 
  end

  def validate_param(param, method)
    begin
      Float(param)
    rescue
      raise_invalid_input(param, method)
    end

    raise_invalid_input(param, method) if param < 0
  end

  def raise_invalid_input(param, method)
    raise "Invalid value #{param} for \##{method}"
  end

  def raise_insufficient_balance(amount)
    raise "Insufficient funds!"
  end
end
