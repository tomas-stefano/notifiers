# frozen_string_literal: true

module Notifiers
  class TerminalNotifier < Notifiers::Base
    COMMAND = 'terminal-notifier'

    def self.installed?
      platform?(/darwin/) and command?(COMMAND)
    end

    def sound(name)
      @sound = name
      self
    end

    def group(id)
      @group = id
      self
    end

    def open(url)
      @open = url
      self
    end

    def execute(command)
      @execute = command
      self
    end

    def to_s
      command = COMMAND.dup
      command << " -title '#{@title}'" if @title
      command << " -message '#{@message}'" if @message
      command << " -contentImage '#{@icon}'" if @icon
      command << " -sound '#{@sound}'" if @sound
      command << " -group '#{@group}'" if @group
      command << " -open '#{@open}'" if @open
      command << " -execute '#{@execute}'" if @execute
      command
    end

    def install_instructions
      'terminal-notifier is not installed. Install with: brew install terminal-notifier'
    end
  end
end
