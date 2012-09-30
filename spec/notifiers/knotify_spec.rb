require 'spec_helper'

describe Knotify do

  before do
    @knotify = Knotify.new
  end

  describe '#message' do
    it "should set the message instance variable" do
      @knotify.message('Bulls on Parade')
      @knotify.instance_variable_get(:@message).should == 'Bulls on Parade'
    end

    it "should be possible to set the message instance variable" do
      @knotify.message('Wake Up')
      @knotify.instance_variable_get(:@message).should == 'Wake Up'
    end
  end

  describe '#title' do

    it "should set the title" do
      @knotify.title('Rage Against the Machine')
      @knotify.instance_variable_get(:@title).should == 'Rage Against the Machine'
    end

    it "should be possible to set the title" do
      @knotify.title('AudioSlave')
      @knotify.instance_variable_get(:@title).should == 'AudioSlave'
    end

  end

  describe '#to_s' do

    it "should return the entire command" do
      command = @knotify.title('Ruby').message('For the Win').to_s
      command.should == "dcop knotify default notify eventname 'Ruby' 'For the Win' '' '' 12 1"
    end

  end

end