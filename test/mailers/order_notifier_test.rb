require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  fixtures :orders

  def setup
    @order = orders(:two)
  end

  test "received" do
    mail = OrderNotifier.received(@order)
    assert_equal "Подтверждение заказа в Pragmatic Store", mail.subject
    assert_equal ["dave@example.com"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /Администрация магазина PRagmatic Store благодарит Вас за недавний заказ/, mail.text_part.body.decoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(@order)
    assert_equal "Заказ из Pragmatic Store отправлен", mail.subject
    assert_equal ["dave@example.com"], mail.to
    assert_equal ["depot@example.com"], mail.from
    #assert_match /1 x Programming Ruby 2.0/, mail.body.encoded
    assert_match /Это сообщение уведомляет Вас, что мы отправили ваш недавний заказ/, mail.text_part.body.decoded
  end

end