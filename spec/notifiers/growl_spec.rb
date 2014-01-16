require 'spec_helper'

describe Growl do
  before do
    @growl = growl
  end

  describe '#image' do
    it "should keep the image" do
      @growl.image('my_image.png')
      expect(@growl.instance_variable_get(:@image)).to eql 'my_image.png'
    end

    it "should set the image" do
      @growl.image('wario.png')
      expect(@growl.instance_variable_get(:@image)).to eql 'wario.png'
    end
  end

  describe '#message' do
    it "should set the message option" do
      @growl.message('Hello World!')
      expect(@growl.instance_variable_get(:@message)).to eql 'Hello World!'
    end

    it "should set the message" do
      @growl.message('May the Force be with you')
      expect(@growl.instance_variable_get(:@message)).to eql 'May the Force be with you'
    end
  end

  describe '#title' do
    it "should set the title" do
      @growl.title('Nirvana')
      expect(@growl.instance_variable_get(:@title)).to eql 'Nirvana'
    end

    it "should set the title option" do
      @growl.title('Pearl Jam')
      expect(@growl.instance_variable_get(:@title)).to eql 'Pearl Jam'
    end
  end

  describe '#priority' do
    it "should set the priority" do
      @growl.priority(0)
      expect(@growl.instance_variable_get(:@priority)).to be 0
    end

    it "should set the priority number" do
      @growl.priority(1)
      expect(@growl.instance_variable_get(:@priority)).to be 1
    end
  end

  describe '#host' do
    it "should set the hostname" do
      @growl.host('localhost')
      expect(@growl.instance_variable_get(:@host)).to eql 'localhost'
    end

    it "should set the host" do
      @growl.host('beer_duff.com')
      expect(@growl.instance_variable_get(:@host)).to eql 'beer_duff.com'
    end
  end

  describe '#password' do
    it "should set the password" do
      @growl.password('top_secret')
      expect(@growl.instance_variable_get(:@password)).to eql 'top_secret'
    end

    it "should set the secret password" do
      @growl.password('paradise_city')
      expect(@growl.instance_variable_get(:@password)).to eql 'paradise_city'
    end
  end

  describe '#auth' do
    it "should set the auth option" do
      @growl.auth('SHA256')
      expect(@growl.instance_variable_get(:@auth)).to eql 'SHA256'
    end
  end

  describe '#to_s' do
    it "should construct the command" do
      command = @growl.message('Hello World!').priority(1).image('mario.png').to_s
      expect(command).to eql "growlnotify --message 'Hello World!' --image mario.png --priority 1"
    end

    it "should construct the command with host password and auth" do
      command = @growl.message('Donuts').host('duff_bear').auth('SHA256').password('welcome_to_the_jungle').to_s
      expect(command).to eql "growlnotify --message 'Donuts' --host duff_bear --password welcome_to_the_jungle --auth SHA256"
    end

    it "should construct the command with title and message" do
      command = @growl.message('Last Kiss').title('Pearl Jam').to_s
      expect(command).to eql "growlnotify --title 'Pearl Jam' --message 'Last Kiss'"
    end
  end
end