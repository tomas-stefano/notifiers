# frozen_string_literal: true

module Notifiers
  class NotifySend < Notifiers::Base
    COMMAND = 'notify-send'

    def self.installed?
      platform?(/(freebsd|linux)/) and command?(COMMAND)
    end

    def urgency(level)
      @urgency = level.to_s
      self
    end

    def expire_time(time)
      @expire_time = time
      self
    end

    def hint(values)
      @hint = values.collect.each { |element| element.to_s }.join(':')
      self
    end

    def category(name)
      @category = name
      self
    end

    def to_s
      command = COMMAND.dup
      command << " --urgency=#{@urgency}" if @urgency
      command << " --expire-time=#{@expire_time}" if @expire_time
      command << " --icon=#{@icon}" if @icon
      command << " --category=#{@category}" if @category
      command << " --hint=#{@hint}" if @hint
      command << " '#{@title}'" if @title
      command << " '#{@message}'" if @message
      command
    end

    def install_instructions
      'notify-send is not installed. Install libnotify for your distribution.'
    end
  end
end