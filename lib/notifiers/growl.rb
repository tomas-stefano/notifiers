class Growl < Notifiers::Base
  def image(icon)
    @image = icon
    self
  end

  def priority(number)
    @priority = number
    self
  end

  def host(hostname)
    @host = hostname
    self
  end

  def password(secret)
    @password = secret
    self
  end

  def auth(authentication)
    @auth = authentication
    self
  end

  def to_s
    command = 'growlnotify'
    command << " --title '#{@title}'" if @title
    command << " --message '#{@message}'"
    [:image, :priority, :host, :password, :auth].each do |option|
      variable = instance_variable_get("@#{option}")
      command << " --#{option} #{variable}" if variable
    end
    command
  end

  def install_instructions
    'The Growl is not installed. You can find more details here: http://growl.info/downloads'
  end
end