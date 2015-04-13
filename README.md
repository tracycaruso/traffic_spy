# Traffic Spy

#####By Tess Griffin, Tracy Caruso and Tom Leskin

Traffic Spy is a web traffic tracking and analysis tool written using Ruby, Sinatra and ActiveRecord.

It will receive data over HTTP from a simulation engine, then the simulator will construct and transmit HTTP requests which include tracking data. Traffic Spy is setup to simulate where a commercial website could embed JavaScript code which gets activated each time a page is viewed on their site. That JavaScript then captures information about the visitor and the page they’re viewing then, in the background, submits the data to the Traffic Spy application. Traffic Spy parses and stores that data, which is analayzed and able to be viewed by the client through an HTML interface.

####Registration

The client using the Traffic Spy web tracker must first submit a request to register with the application.

The registration request includes the client's identifier, such as 'jumpstartlab' or 'google' and root URL, such as 'http://jumpstartlab.com' or 'http://www.google.com'.

![img](http://i.imgur.com/WWERnMe.png "Register")

Once the request is submitted, the client will receive a message such as '200 OK Success', '400 Bad Request' or '403 Forbidden Identifier Already Exists'.

![img](http://i.imgur.com/0T7aK6I.png "403")


####Sending POST requests

After the client is registered with Traffic Spy, they can then send POST requests to the application that will accept JSON data, parse it and store it in a database.

Data in the request includes the URL visited, time it was requested at, response time, URL it was referred by, request type, parameters, event name, user agent, such as information about the browser and OS the user was using, resolution the site was viewed at and their IP address.

![img](http://i.imgur.com/KBMyyfI.png "POST")

####Dashboard

After the client has registered and submitted POST requests, the data can be viewed through an HTML interface.

The client can view their dashboard by visiting 'http://localhost:9393/sources/identifier', replacing 'identifier' with their own identifier. For Jumpstart Lab, the address would be 'http://localhost:9393/sources/jumpstartlab'.

![img](http://i.imgur.com/tYYQOEZ.png "Dashboard")

The dashboard will show the browsers and platforms used to view the page, visited URLs, resolutions and average response time.

####Visited URLs

If the client clicks one of the links for the a visited URL, it will take them to another page such as 'http://localhost:9393/sources/jumpstartlab/urls/blog' that displays information about the URL. Information on this page includes the longest, shortest and average response times, all request types, most popular referrer and the most popular browser

![img](http://i.imgur.com/3AKUDvf.png "Visited URLs")

####Event Data

If the client clicks the link in the sidebar to view Event Data, it will take them to a page such as 'http://localhost:9393/sources/jumpstartlab/events' and it displays the events ordered from the most received to the least received event.

![img](http://i.imgur.com/ljdInpD.png "Event Data")

####Specific Event Data

On the event data page, if the client clicks on a link for a specific event, it will take them to a page to view information for that event. The link will take them to a page such  as 'http://localhost:9393/sources/jumpstartlab/events/socialLogin'. The page they are taken to will display an hourly breakdown of how many times that event occurred and a total count of how many times that event occurred.

![img](http://i.imgur.com/RAH4mRq.png "Specific Event Data")

####Additional Project Information

This project was completed as part of the curriculum at the [Turing School of Software & Design](http://turing.io/). For more information, visit http://tutorials.jumpstartlab.com/projects/traffic_spy.html.
