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

    def notify
      system(to_s)
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
  end
end