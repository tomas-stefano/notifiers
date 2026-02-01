# frozen_string_literal: true

%i[base terminal_notifier osascript notify_send dunstify notifier_not_found].each do |notifier|
  require "notifiers/#{notifier}"
end

module Notifiers
  def terminal_notifier
    TerminalNotifier.new
  end

  def osascript
    Osascript.new
  end

  def notify_send
    NotifySend.new
  end
  alias lib_notify notify_send

  def dunstify
    Dunstify.new
  end

  def auto_discover
    notifier = Notifiers::Base.subclasses.find(&:installed?) or raise NotifierNotFound

    notifier.new
  end
end