require 'spec_helper'

describe NotifySend do
  
  before do
    @notify_send = notify_send
  end
  
  describe '#image' do
    
    it "should set the image" do
      @notify_send.image('my_image.png')
      @notify_send.instance_variable_get(:@icon).should eql 'my_image.png'
    end
    
    it "should set the icon option" do
      @notify_send.image('homer_simpson.png')
      @notify_send.instance_variable_get(:@icon).should eql 'homer_simpson.png'
    end

  end
  
  describe '#message' do
    
    it "should set the message" do
      @notify_send.message('Oh Donuts!')
      @notify_send.instance_variable_get(:@message).should eql 'Oh Donuts!'
    end
    
    it "should set the message option" do
      @notify_send.message('Duff Beer')
      @notify_send.instance_variable_get(:@message).should eql 'Duff Beer'
    end
    
  end
  
end