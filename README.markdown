# Notifier

Use notifications in a simple and elegant way. :)

## Install

  gem install notifiers

# Usage

     require 'notifiers'
     include Notifiers

## Growl

     growl.message('Hi Growl!').image('my_image.png').priority(2).name('my_app').notify!

## Lib_Notify

     notify_send.image('my_image.png').message('Hi Growl').notify!

## Why I created this gem?

#### Only one explanation:

##### <b>Because is fun! =)</b>
