class Transfer
  # your code here
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    self.sender = sender
    self.receiver = receiver
    self.status = 'pending'
    self.amount = amount
  end

  def valid?
    self.sender.valid? && self.receiver.valid? && self.sender.balance > self.amount
  end

  def execute_transaction
    if self.status == 'pending' && self.valid?
      self.receiver.deposit(self.amount)
      self.sender.deposit(-1*self.amount)
      self.status = 'complete'
    else
      self.status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == 'complete'
      self.receiver.deposit(-1*self.amount)
      self.sender.deposit(self.amount)
      self.status = 'reversed'
    else
      "Cannot reverse a completed transaction"
    end
  end



end
