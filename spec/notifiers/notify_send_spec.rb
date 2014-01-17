require 'spec_helper'

describe NotifySend do
  it_should_behave_like 'a notifier'
  
  before do
    @notify_send = notify_send
  end

  describe '#image' do
    it "should set the image" do
      @notify_send.image('my_image.png')
      expect(@notify_send.instance_variable_get(:@icon)).to eql 'my_image.png'
    end

    it "should set the icon option" do
      @notify_send.image('homer_simpson.png')
      expect(@notify_send.instance_variable_get(:@icon)).to eql 'homer_simpson.png'
    end
  end

  describe '#message' do
    it "should set the message" do
      @notify_send.message('Oh Donuts!')
      expect(@notify_send.instance_variable_get(:@message)).to eql 'Oh Donuts!'
    end

    it "should set the message option" do
      @notify_send.message('Duff Beer')
      expect(@notify_send.instance_variable_get(:@message)).to eql 'Duff Beer'
    end
  end

  describe '#title' do
    it "should set the title" do
      @notify_send.title('W00T!!')
      expect(@notify_send.instance_variable_get(:@title)).to eql 'W00T!!'
    end

    it "should set a title as intance variable" do
      @notify_send.title('Joker Owned Batman!')
      expect(@notify_send.instance_variable_get(:@title)).to eql 'Joker Owned Batman!'
    end
  end

  describe '#urgency' do
    it "should set the urgency instance variable to low" do
      @notify_send.urgency(:low)
      expect(@notify_send.instance_variable_get(:@urgency)).to eql 'low'
    end

    it "should set he urgency instance variable to normal" do
      @notify_send.urgency(:normal)
      expect(@notify_send.instance_variable_get(:@urgency)).to eql 'normal'
    end

    it "should set the urgency to critical" do
      @notify_send.urgency(:critical)
      expect(@notify_send.instance_variable_get(:@urgency)).to eql 'critical'
    end
  end

  describe '#expire_time' do
    it "should set the expire time" do
      @notify_send.expire_time(1000)
      expect(@notify_send.instance_variable_get(:@expire_time)).to eql 1000
    end

    it "should set the expire time in miliseconds" do
      @notify_send.expire_time(2000)
      expect(@notify_send.instance_variable_get(:@expire_time)).to eql 2000
    end
  end

  describe '#hint' do
    it "should set the hint" do
      @notify_send.hint([:string, :me, :yeah])
      expect(@notify_send.instance_variable_get(:@hint)).to eql 'string:me:yeah'
    end

    it "should set the hint in int" do
      @notify_send.hint([:int, :me, 1])
      expect(@notify_send.instance_variable_get(:@hint)).to eql 'int:me:1'
    end
  end

  describe '#to_s' do
    it "should transform in a command" do
      command = @notify_send.title('Inception').message('3 levels').image('my_image.png').to_s
      expect(command).to eql "notify-send --icon=my_image.png 'Inception' '3 levels'"
    end

    it "should transform in a command to execute" do
      command = @notify_send.title('Joker').message('Haha ha!').expire_time(1000).hint([:string, :me, :woot]).to_s
      expect(command).to eql "notify-send --hint=string:me:woot --expire-time=1000 'Joker' 'Haha ha!'"
    end

    it "should transform in a command to execute" do
      command = @notify_send.title('Batman').urgency(:critical).to_s
      expect(command).to eql "notify-send --urgency=critical 'Batman'"
    end
  end
end