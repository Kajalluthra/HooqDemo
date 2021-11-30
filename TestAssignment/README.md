# HooqDemo
# README #

This README would normally document whatever steps are necessary to get your application up and running.

* Version Required Software(known):
Xcode 12.5 

* Language and version Used:
Swift 5.4

###  Steps to setup code ###
1. Download the project and unzip
2. Open the HooqDemo.xcodeproj
3. Click the Play button to run the application in simulator

### A quick guide ####
1. The code is written in Swift 5.4 followed by MVVM
2. The app consist of 2 screens: 
- HomeVC
- DetailVC 

3. HomeVC 
- It consist of a CollectionView with 1 section.
- HomeCollectionCell : It is a vertical sliding collection view cell with Movie Image.
- HomeViewModel is the manager for HomeVC, which consist of the business logic and allows the ViewController to manage the View with the model. 
- Click on the HomeCollectionCell makes Navigation to DetailVC:

4. DetailVC
- It consist of Movie Image, title, release date and description. It also consist of a Tableview which represents similar movies.
- DetailTableViewCell: It is a TableView cell with a horizontal listing of Movie Images.

5. NetworkService is been used throughout the app for the all the HTTPs request followed by their manager respectively.

6. LoadingView is the loading screen in the centre of the screen 

7. CustomImageView is a subclass of UIImagView for loading and cache the images 


### Contribution guidelines ###
Kajal
https://www.linkedin.com/in/kajal-luthra-444a0881/
