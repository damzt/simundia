class MyError < StandardError

  attr_reader :error_message

  def initialize(error_message)
    super(error_message)
  end

end