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

    def self.darwin?
      platform?(/darwin/)
    end

    def self.platform?(name)
      RbConfig::CONFIG['host_os'] =~ name or RUBY_PLATFORM =~ name
    end

    def self.command?(command)
      `which #{command}` and $?.zero?
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