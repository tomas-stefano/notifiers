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
  end
end