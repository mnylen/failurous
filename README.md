# Failurous

Failurous is an open source webapp for monitoring exceptions in your
live applications.

## Installation

### Server

The Failurous server is pretty much just a cookie-cutter Rails 3 application, which uses MongoDB as the backend. As prerequisites you'll need:

* [MongoDB](http://www.mongodb.org/downloads)
* Ruby 1.8 or newer

When you have these two installed, and MongoDB up and running, just clone this repository and hit `rails server -e production`. By default the server will start in port 3000.


### Clients

#### Rails 3

To use Failurous from Rails 3 application, add this to your Gemfile:

    gem 'failurous-rails', :git => 'git://github.com/railsrumble/rr10-team-256.git'


Next you need to add the following under config/initializer/failurous.rb:

    require 'failurous'

    Failurous::Config.server_address = '<FAILUROUS-INSTALLATION>'
    Failurous::Config.api_key = '<API-KEY-FOR-PROJECT>'

    Rails.application.config.middleware.use Failurous::FailMiddleware
      
The middleware will automatically catch any exceptions your app raises and
deliver them to the Failurous service for later viewing.

#### Java

To integrate Failurous to a Java webapp, first add the Failurous Maven repository to your Maven POM:

    <repository>
      <id>failurous</id>
      <url>http://failurous.r10.railsrumble.com/mvnrepo</url>
      <snapshots>
        <enabled>true</enabled>
      </snapshots>
      <releases>
        <enabled>true</enabled>
      </releases>
    </repository>
		
Next, add a dependency to the Failurous Java client:

    <dependency>
      <groupId>failurous</groupId>
      <artifactId>javaclient</artifactId>
      <version>0.0.1-SNAPSHOT</version>
    </dependency>
		
Finally, configure the Failurous Java client to intercept exceptions by adding it as a servlet filter to your web.xml:

	<filter>
		<filter-name>failurous</filter-name>
		<filter-class>failurous.ClientFilter</filter-class>
		<init-param>
			<param-name>serverAddress</param-name>
			<param-value><FAILUROUS-INSTALLATION></param-value>
		</init-param>
		<init-param>
			<param-name>apiKey</param-name>
			<param-value><API-KEY-FOR-PROJECT></param-value>
		</init-param>
	</filter>
	
	<filter-mapping>
		<filter-name>failurous</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
		
The filter will automatically catch any exceptions your app threw and deliver them to the Failurous service for later viewing.

Notice that the position of the filter-mapping element affects which exceptions Failurous will report. Any filter mappings appearing before the failurous filter mapping in web.xml will not be reported, since they are executed outside its scope.

## Sending fails

Often there's cases where it'd be desirable to be able to send debugging
information or notifications of "failurous" behaviour in your application. For
example, when someone tries to access protected content without proper access
rights.

Failurous comes in handy here, because it's not limited to only
exceptions: you can actually send any data you like.

### In Rails applications

To send your custom fails to Failurous, you can use the
`Failurous::FailNotification` to build your fail and send it. The syntax is
as follows:

    Failurous::FailNotification.set_title('Title for your fail').
      add_field(:section_name, :field_name, {:use_in_checksum => true | false}).
      add_field(:another, :field, {...}).
      send


## License

Copyright (c) 2010 Mikko Nylén, Tero Parviainen & Antti Forsell

See LICENSE


