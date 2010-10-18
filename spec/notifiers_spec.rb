require 'spec_helper'

describe 'notifiers' do

  it { growl.should be_instance_of(Growl) }
  
  it { knotify.should be_instance_of(Knotify) }
  
  it { notify_send.should be_instance_of(NotifySend)}
  
end