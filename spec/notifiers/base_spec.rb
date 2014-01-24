require 'spec_helper'

module Notifiers
  describe Base do
    describe '.subclasses' do
      it { expect(Base.subclasses).to include(Growl, Knotify, NotifySend) }
    end

    describe '.installed?' do
      it 'returns false as default' do
        expect(Base).to_not be_installed
      end
    end
  end
end