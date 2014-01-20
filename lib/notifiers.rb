[:base, :growl, :knotify, :notify_send, :notifier_not_found].each do |notifier|
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

  def auto_discover
    notifier = Notifiers::Base.subclasses.find { |notifier| notifier.installed? } or raise NotifierNotFound

    notifier.new
  end
end