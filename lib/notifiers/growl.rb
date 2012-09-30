class Growl
  COMMAND = "growlnotify"

  def image(icon)
    @image = icon
    self
  end

  def title(text)
    @title = text
    self
  end

  def message(text)
    @message = text
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
    command = COMMAND.clone
    command << " --title '#{@title}'" if @title
    command << " --message '#{@message}'"
    [:image, :priority, :host, :password, :auth].each do |option|
      variable = instance_variable_get("@#{option}")
      command << " --#{option} #{variable}" if variable
    end
    command
  end

  def notify!
    system(to_s)
  end

end