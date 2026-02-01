# frozen_string_literal: true

require 'spec_helper'

describe Notifiers do
  it { expect(terminal_notifier).to be_instance_of(Notifiers::TerminalNotifier) }

  it { expect(osascript).to be_instance_of(Notifiers::Osascript) }

  it { expect(notify_send).to be_instance_of(Notifiers::NotifySend) }

  it { expect(lib_notify).to be_instance_of(Notifiers::NotifySend) }

  it { expect(dunstify).to be_instance_of(Notifiers::Dunstify) }

  describe '#auto_discover' do
    context 'when have a notifier library installed' do
      it 'returns the notifier' do
        expect(Notifiers::TerminalNotifier).to receive(:installed?).and_return(true)
        expect(auto_discover).to be_instance_of(Notifiers::TerminalNotifier)
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