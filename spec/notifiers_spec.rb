require 'spec_helper'

describe Notifiers do
  it { expect(growl).to be_instance_of(Notifiers::Growl) }

  it { expect(knotify).to be_instance_of(Notifiers::Knotify) }

  it { expect(notify_send).to be_instance_of(Notifiers::NotifySend) }

  it { expect(lib_notify).to be_instance_of(Notifiers::NotifySend) }

  describe '#auto_discover' do
    context 'when have a notifier library installed' do
      it 'returns the notifier' do
        expect(Notifiers::Growl).to receive(:installed?).and_return(true)
        expect(auto_discover).to be_instance_of(Notifiers::Growl)
      end
    end

    context 'when do not have a notifier library installed' do
      it 'raises Notifier not Found' do
        expect(Notifiers::Base).to receive(:subclasses).and_return([])
        expect {
          auto_discover
        }.to raise_error(Notifiers::NotifierNotFound)
      end
    end
  end
end