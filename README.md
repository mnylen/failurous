# Failurous

Failurous is an open source webapp for monitoring exceptions in your
live applications.

## Installation

The Failurous server is pretty much just a cookie-cutter Rails 3 application, which uses MongoDB as the backend. As prerequisites you'll need:

* [MongoDB](http://www.mongodb.org/downloads)
* Ruby 1.8 or newer

When you have these two installed, and MongoDB is up and running, just clone this repository and run `bundle install` to install the required gems. Then hit `rails server -e production` to start the app. By default the server will start in port 3000.


## Clients

* [Rails 3](http://github.com/mnylen/failurous-rails) - failurous-rails


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


## License

Copyright (c) 2010 Mikko Nylén, Tero Parviainen & Antti Forsell

See LICENSE


