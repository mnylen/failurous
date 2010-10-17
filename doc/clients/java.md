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
