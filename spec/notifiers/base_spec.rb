require 'spec_helper'

module Notifiers
  describe Base do
    describe '.subclasses' do
      it { expect(Base.subclasses).to include(Growl, Knotify, NotifySend) }
    end
  end
end