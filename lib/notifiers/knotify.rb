class Knotify < Notifiers::Base
  COMMAND = "dcop knotify default notify eventname"

  def message(text)
    @message = text
    self
  end

  def title(text)
    @title = text
    self
  end

  def to_s
    command = "#{COMMAND}"
    command << " '#{@title}'" if @title
    command << " '#{@message}'" if @message
    command << " '' ''"
    command << " 12 1"
    command
  end
end