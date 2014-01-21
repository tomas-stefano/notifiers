class NotifySend < Notifiers::Base
  COMMAND = 'notify-send'

  def urgency(level)
    @urgency = level.to_s
    self
  end

  def expire_time(time)
    @expire_time = time
    self
  end

  def hint(values)
    @hint = values.collect.each { |element| element.to_s}.join(':')
    self
  end

  def to_s
    command = COMMAND.clone
    [:hint, :priority, :icon, :urgency].each do |option|
      variable = instance_variable_get("@#{option}")
      command << " --#{option}=#{variable}" if variable
    end
    command << " --expire-time=#{@expire_time}" if @expire_time
    [:title, :message].each do |option|
      variable = instance_variable_get("@#{option}")
      command << " '#{variable}'" if variable
    end
    command
  end
end