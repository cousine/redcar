
*Important*

Currently Redcar is being ported to JRuby, and not a lot works on HEAD. Please download anyway if you 
are interested in developing Redcar.

{Redcar}
========

by Daniel Lucraft
http://RedcarEditor.com/

## DESCRIPTION

A pure Ruby text editor running on JRuby. 

## INSTALLATION

You must have Java installed. 

    $ sudo gem install redcar --pre
    
NB the install will take a minute or so to complete as it has to download about
15MB of jar files.

## PROBLEMS?

* Irc at #redcar on irc.freenode.net
* Mailing list at http://groups.google.com/group/redcar-editor

## TESTS

To run all specs and features:

    $ jruby -S rake

NB. Features work with Cucumber version 0.4.2, you may have problems with other versions because for the moment we are patching Cucumber dynamically to support dependencies between sets of features.

## TESTS (specs)

On OSX:

    $ jruby -J-XstartOnFirstThread -S spec plugins/#{plugin_name}/spec/

On Linux:

    $ jruby -S spec plugins/#{plugin_name}/spec/

  
## TESTS (features)

On OSX:

    $ jruby -J-XstartOnFirstThread bin/cucumber plugins/#{plugin_name}/features

On Linux:

    $ jruby bin/cucumber plugins/#{plugin_name}/features/

## LICENSE

Redcar is copyright 2007-2009 Daniel Lucraft and contributors. 
It is licensed under the GPL2. See the included LICENSE file for details.

