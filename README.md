# HooqDemo
# README #

This README would normally document whatever steps are necessary to get your application up and running.

* Version Required Software(known):
Xcode 10.1 
(Xcode 10.1 includes SDKs for iOS 12.1, watchOS 5.1, macOS 10.14.1, and tvOS 12.1. Xcode 10.1 supports on-device debugging for iOS 8 and later, tvOS 9 and later, and watchOS 2 and later. Xcode 10.1 requires a Mac running macOS 10.13.6 or later)

*Language and version Used:
Swift 4.2

###  Steps to setup code ###
1. Download the project and unzip
2. Open the HooqDemo.xcodeproj
3. Click the Play button to run the application in simulator
4. Run the Test to see the Test coverage

###  Good to see ###
1. Current Test covergae = 63.2%
2. Number of warnings while compile = 0

### A quick guide ####
1. The code is written in Swift 4.2 followed by MVVM
2. The app consist of 4 screens: 
- HomeVC
- DetailVC 

3. HomeVC 
- It consist of a CollectionView with 1 sections.
- HomeCollectionCell : It is a vertical sliding collection view cell with Movie Image.
- HomeViewModel is the manager for HomeVC, which consist of the busines logic and allows the ViewController to manage the View with the model. 
- Click on the HomeCollectionCell makes Navigation to DetailVC:

4. DetailVC
- It consist of Movie Image, title, release date and description. It also consist of a Tableview which represents similar movies.
- DetailTableViewCell: It is a TableView cell with a horizontal listing of Movie Images.

5) Api Manager is been used throughout the app for the all the HTTPs request followed by their manager respectively.

### Contribution guidelines ###
Kajal
https://www.linkedin.com/in/kajal-luthra-444a0881/


