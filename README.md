# CraveApp

An iOS app built for a local, family-owned restaurant (http://www.ilovecrave.com) using Swift and Firebase. 
I learned A LOT more about networking and databases during this project. I also got MUCH more familiar with sublassing UIViews to create custom views and cells
that look way sexier than anything built into UIKit. 

# Some skills I learned/implemented are:
  - Firebase's Cloud Firestore
  - Continually getting better at structuring and organizing code, I used MVC architecture for this project
  - Networking, making calls to a database and populating UI elements with data
  - Subclassing UIViews, especially table/collection cells
  - Using buttons to make calls, send emails, and open directions on Apple Maps
  - Got way better at using and understanding MapKit
  - Completion handlers/closures are getting way, way simpler

# Some of the challenges I faced were:
 - Figuring out how to filter items, I opted to use an array of strings within the database that acted as "tags" which is used to filter menu items.
 - Working with autolayout, especially on subviews of a custom UIView. This taught me a lot about autolayout as well as subclasses of different UIViews. It
 is definitely easier to make custom table/collection cells than it is to create an entire screen in a subclass of UIView so that it can be properly
 embedded in a UIScrollView
 - Learning how Cloud Firestore works. I had been working with Firebase's Realtime Database before, and Firestore is very different, but much more useful for most
 use cases in my opinion.
 - Deciding how to structure my collections in Cloud Firestore, having to make decisions based on what would be read/written to the most.
 - Figuring out how to make MapKit do what I want since it is definitely much messier to learn than some of the other APIs provided by Apple.
 - Deciding how to filter the menu items. I opted against using Firestore's queries since I had already queried the data to display menu items.
 I instead used a custom table view and a number of filter functions combined with a search bar to only show data matching the user's queries, but hold on to
 the rest of the menu data. This also lowers the amount of reads from the DB required.

