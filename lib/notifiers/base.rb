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

    def notify
      notification = system(to_s)

      puts install_instructions unless notification

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
      raise NotImplementedError
    end
  end
end