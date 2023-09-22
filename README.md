# Recycling Finder
### Hi there, I'm Muharrem <img src = "https://raw.githubusercontent.com/MartinHeinz/MartinHeinz/master/wave.gif" width = "42"> 
#### Thank You for taking the time to view my repository 

## <h2> About This App <img src = "https://c.tenor.com/JsoERRQcZqYAAAAi/thumbs-up-joypixels.gif" width = "42"></h2>
This app is a recycle bin finder. Shows developers how to use the MapKit package. A LaunchScreen greets us on the screen while the application is opening. We've extended the duration of this screen with a minor change to the AppDelegate page. When the application is opened, a TableView structure appears. Here the user can see the list of the boxes he has saved, click on it and go to the details about the box. In order to use the TableView class, we first added the UITableViewDelegate, UITableViewDataSource classes to our application. Then we added the delegate and dataSource structures in viewDidLoad. After that, we added the necessary numberOfRowsInSection and cellForRowAt functions for the TableView. We used the didSelectRowAt function so that the user can click on the element in the list and see its details, while we used the commit function to delete records from the list. We placed an add button on the Navigation Controller Bar as there will be a transition between the screens in the application. In this way, the user can go to the new record adding screen. We pulled the data from CoreData so that the records can be listed. While doing this, we made use of the NSFetchRequest method. The insert page has a TextField, an ImageView, and a Map. For map usage, we first added the MapKit library to the application. Then we used the CoreLocation class to get the instant location of the user. We created a CLLocationManager variable with this class. Then we used the didUpdateLocations function and made special zoom and region settings for our location. Then we made the user add an annotation by pressing and holding on the map. For this process, we first created a GestureRecognizer. We processed this touch operation in the annotation function. A Callout appears when clicking on the annotation. We made this feature with the viewFor annotation function. As you can see in this function, we have placed a button on the right side of the Callout screen. We added a navigation feature to this button with the calloutAccessoryControlTapped function. In this way, the user can navigate to the location of the box in the fastest way on the maps. Apart from that, we used the UIImagePickerController class so that the user can select the photo taken from the gallery. In this way, the user can record the picture of the box he pinned. Then there is a save button at the bottom. This button contains the registration operations of the CoreData class. In this way, the user, who fills in the information completely, can save this information using CoreData at the last stage. Finally, we designed an icon for our application and placed it in our application.

<h2> Used Technologies <img src = "https://media2.giphy.com/media/QssGEmpkyEOhBCb7e1/giphy.gif?cid=ecf05e47a0n3gi1bfqntqmob8g9aid1oyj2wr3ds3mg700bl&rid=giphy.gif" width = "42"> </h2>
<div class="row">
      <div class="column">
<img width ='72px' src 
     ='https://raw.githubusercontent.com/MuharremKoroglu/MuharremKoroglu/main/swift-icon.svg'>
  </div>
</div>

<h2> Used Language <img src = "https://media.giphy.com/media/Zd6jPg8hcp4Q3vrvjo/giphy.gif" width = "42"> </h2>
<div class="row">
      <div class="column">
<img width ='82px' src 
     ='https://upload.wikimedia.org/wikipedia/commons/a/a5/Flag_of_the_United_Kingdom_%281-2%29.svg'>
  </div>
</div>

<h2> Images <img src = "https://media2.giphy.com/media/psneItdLMpWy36ejfA/source.gif" width = "62"> </h2>
  <div class="column">


https://user-images.githubusercontent.com/68854616/195352613-93153f64-2c42-45bc-b5fb-ebf9788d5524.mp4


  </div>
<h2> Connect with me <img src='https://raw.githubusercontent.com/ShahriarShafin/ShahriarShafin/main/Assets/handshake.gif' width="100"> </h2>
<a href = 'mailto:muharremkoroglu245@gmail.com'> <img align="center" width = '32px' align= 'center' src="https://raw.githubusercontent.com/MuharremKoroglu/MuharremKoroglu/main/gmail-logo-2561.svg"/></a> &nbsp;
<a href = 'https://www.linkedin.com/in/muharremkoroglu/'> <img align="center" width = '32px' align= 'center' src="https://raw.githubusercontent.com/rahulbanerjee26/githubAboutMeGenerator/main/icons/linked-in-alt.svg"/></a> &nbsp;
<a href = 'https://muharremkoroglu.medium.com/'> <img align="center" width = '32px' align= 'center' src="https://raw.githubusercontent.com/rahulbanerjee26/githubAboutMeGenerator/main/icons/medium.svg"/></a> &nbsp;
<a href="https://www.instagram.com/m.koroglu99/" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/instagram.svg" alt="_._.adam._"  width="32px" align= 'center' /></a> &nbsp;
<a href = 'https://synta-x.com/'> <img align="center" width = '32px' align= 'center' src="https://raw.githubusercontent.com/MuharremKoroglu/MuharremKoroglu/main/internet-svgrepo-com%20(2).svg"/></a> &nbsp;
















