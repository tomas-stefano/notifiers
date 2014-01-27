require 'spec_helper'

module Notifiers
  describe Base do
    subject(:base) do
      Base.new
    end

    describe '.subclasses' do
      it { expect(Base.subclasses).to include(Growl, Knotify, NotifySend) }
    end

    describe '.installed?' do
      it 'returns false as default' do
        expect(Base).to_not be_installed
      end
    end

    describe '.darwin?' do
      context 'when the ruby platform is darwin' do
        it 'returns true' do
          expect(Base).to receive(:platform?).with(/darwin/).and_return(true)
          expect(Base.darwin?).to be true
        end
      end

      context 'when the ruby platform is not darwin' do
        it 'returns false' do
          expect(Base).to receive(:platform?).with(/darwin/).and_return(false)
          expect(Base.darwin?).to be false
        end
      end
    end

    describe '#notify' do
      before do
        expect(base).to receive(:to_s).and_return('example')
      end

      context 'when the notify command runs without error' do
        it 'calls system on #to_s method' do
          expect(base).to receive(:system).with('example').and_return(true)
          expect(base.notify).to be true
        end
      end

      context 'when the notify command runs with error' do
        it 'puts a install instruction if the system command returns false' do
          expect(base).to receive(:system).with('example').and_return(false)
          expect(base).to receive(:install_instructions).at_least(:once).and_return('Install')
          expect(base).to receive(:puts).with('Install')
          expect(base.notify).to be false
        end

        it 'do nothing when the instance does not have install instructions' do
          expect(base).to receive(:system).with('example').and_return(false)
          expect(base).to receive(:install_instructions).exactly(:once).and_return('')
          expect(base).to_not receive(:puts)
          expect(base.notify).to be false
        end
      end
    end
  end
end