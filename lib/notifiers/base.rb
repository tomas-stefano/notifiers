module Notifiers
  class Base
    def notify
      system(to_s)
    end
    alias :notify! :notify
  end
end