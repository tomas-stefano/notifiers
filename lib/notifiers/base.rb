# frozen_string_literal: true

module Notifiers
  class Base
    def self.inherited(subclass)
      @subclasses ||= []
      @subclasses.push(subclass)
      @subclasses
    end

    def self.subclasses
      @subclasses
    end

    def self.installed?
      false
    end

    def self.platform?(name)
      RbConfig::CONFIG['host_os'] =~ name or RUBY_PLATFORM =~ name
    end

    def self.command?(command)
      `which #{command}` and success_process_status?
    end

    def self.process?(process_name)
      `ps -A #{process_name}` and success_process_status?
    end

    def self.success_process_status?
      $?.to_i.zero?
    end

    def notify
      notification = system(to_s)

      puts install_instructions unless notification or install_instructions.empty?

      notification
    end
    alias :notify! :notify

    def message(text)
      @message = text
      self
    end

    def title(text)
      @title = text
      self
    end

    def image(icon)
      @icon = icon
      self
    end

    def install_instructions
      ''
    end
  end
end