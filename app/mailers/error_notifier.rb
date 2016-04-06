class ErrorNotifier < ActionMailer::Base
  default from: "Vladimir Vasilyev <depot@example.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.error_notifier.failure_notice.subject
  #
  def failure_notice(failure)
    @failure = failure

    mail to: "vladi_it@mail.ru", subject: "Исключение в работе приложения Depot"
  end
end
