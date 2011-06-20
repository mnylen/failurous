class Notifier < ActionMailer::Base
  default :from => EMAIL_NOTIFICATION_SENDER

  def fail_landed(fail)
    @fail    = fail
    @project = fail.project

    subject = "#{EMAIL_NOTIFICATION_SUBJECT_PREFIX} Project #{@project.name} failed: #{@fail.title}"
    mail(:to      => @project.email_notification_recipients,
         :subject => subject)
  end
end
