class Invite < ActionMailer::Base
  default from: "from@example.com"


  def hello(content)
    @name = content
    mail(
      to:      'yoshiki.mc@gmail.com',
      subject: 'Mail from Message',
    ) do |format|
      format.html
    end
  end
end
