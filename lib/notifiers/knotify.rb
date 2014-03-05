module Notifiers
  class Knotify < Notifiers::Base
    COMMAND = "dcop knotify default notify eventname"

    def self.installed?
      platform?(/(freebsd|linux)/) and process?('dcop')
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
end