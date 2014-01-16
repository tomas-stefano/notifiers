require 'spec_helper'

describe 'notifiers' do
  it { expect(growl).to be_instance_of(Growl) }

  it { expect(knotify).to be_instance_of(Knotify) }

  it { expect(notify_send).to be_instance_of(NotifySend) }

  it { expect(lib_notify).to be_instance_of(NotifySend) }
end