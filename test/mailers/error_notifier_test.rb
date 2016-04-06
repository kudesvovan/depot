require 'test_helper'

class ErrorNotifierTest < ActionMailer::TestCase
  fixtures :orders

  def setup 
  	@failure = "The error happened."
  end

  test "failure_notice" do
    mail = ErrorNotifier.failure_notice(@failure)
    assert_equal "Исключение в работе приложения Depot", mail.subject
    assert_equal ["vladi_it@mail.ru"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /The error happened./, mail.body.encoded
  end

end
