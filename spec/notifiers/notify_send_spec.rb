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
  
  describe '#title' do
    
    it "should set the title" do
      @notify_send.title('W00T!!')
      @notify_send.instance_variable_get(:@title).should == 'W00T!!'
    end
    
    it "should set a title as intance variable" do
      @notify_send.title('Joker Owned Batman!')
      @notify_send.instance_variable_get(:@title).should == 'Joker Owned Batman!'
    end
    
  end
  
  describe '#urgency' do
    
    it "should set the urgency instance variable to low" do
      @notify_send.urgency(:low)
      @notify_send.instance_variable_get(:@urgency).should == 'low'
    end
    
    it "should set he urgency instance variable to normal" do
      @notify_send.urgency(:normal)
      @notify_send.instance_variable_get(:@urgency).should == 'normal'
    end
    
    it "should set the urgency to critical" do
      @notify_send.urgency(:critical)
      @notify_send.instance_variable_get(:@urgency).should == 'critical'
    end
    
  end
  
  describe '#expire_time' do
    
    it "should set the expire time" do
      @notify_send.expire_time(1000)
      @notify_send.instance_variable_get(:@expire_time).should == 1000
    end
    
    it "should set the expire time in miliseconds" do
      @notify_send.expire_time(2000)
      @notify_send.instance_variable_get(:@expire_time).should == 2000
    end
    
  end
  
  describe '#hint' do
    
    it "should set the hint" do
      @notify_send.hint([:string, :me, :yeah])
      @notify_send.instance_variable_get(:@hint).should == 'string:me:yeah'
    end
    
    it "should set the hint in int" do
      @notify_send.hint([:int, :me, 1])
      @notify_send.instance_variable_get(:@hint).should == 'int:me:1'
    end
    
  end
 
  describe '#to_s' do
    
    it "should transform in a command" do
      command = @notify_send.title('Inception').message('3 levels').image('my_image.png').to_s
      command.should == "notify-send --icon=my_image.png 'Inception' '3 levels'"
    end
    
    it "should transform in a command to execute" do
      command = @notify_send.title('Joker').message('Haha ha!').expire_time(1000).hint([:string, :me, :woot]).to_s
      command.should == "notify-send --hint=string:me:woot --expire-time=1000 'Joker' 'Haha ha!'"
    end
    
    it "should transform in a command to execute" do
      command = @notify_send.title('Batman').urgency(:critical).to_s
      command.should == "notify-send --urgency=critical 'Batman'"
    end
    
  end
 
end