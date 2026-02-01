# frozen_string_literal: true

module Notifiers
  class Dunstify < Notifiers::Base
    COMMAND = 'dunstify'

    def self.installed?
      platform?(/(freebsd|linux)/) and command?(COMMAND)
    end

    def urgency(level)
      @urgency = level.to_s
      self
    end

    def timeout(milliseconds)
      @timeout = milliseconds
      self
    end

    def action(action_string)
      @action = action_string
      self
    end

    def replace(id)
      @replace = id
      self
    end

    def to_s
      command = COMMAND.dup
      command << " -u '#{@urgency}'" if @urgency
      command << " -t '#{@timeout}'" if @timeout
      command << " -i '#{@icon}'" if @icon
      command << " -r '#{@replace}'" if @replace
      command << " -A '#{@action}'" if @action
      command << " '#{@title}'" if @title
      command << " '#{@message}'" if @message
      command
    end

    def install_instructions
      'dunstify is not installed. Install dunst notification daemon for your distribution.'
    end
  end
end
