[ :growl, :knotify, :notify_send].each do |notifier|
  require "notifiers/#{notifier}"
end

module Notifiers

  def growl
    Growl.new
  end
  
  def knotify
    Knotify.new
  end
  
  def notify_send
    NotifySend.new
  end
  alias :lib_notify :notify_send
  
end