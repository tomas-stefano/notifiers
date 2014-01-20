require 'spec_helper'

describe 'notifiers' do
  it { expect(growl).to be_instance_of(Growl) }

  it { expect(knotify).to be_instance_of(Knotify) }

  it { expect(notify_send).to be_instance_of(NotifySend) }

  it { expect(lib_notify).to be_instance_of(NotifySend) }

  describe '#auto_discover' do
    context 'when have a notifier library installed' do
      it 'returns the notifier' do
        expect(Growl).to receive(:installed?).and_return(true)
        expect(auto_discover).to be_instance_of(Growl)
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