# Evolve.Markets iOS App

An application for viewing and managing Evolve.Markets accounts.

App is designed to be more mobile friendly than the website using Evolve.Markets API.

# Installation


Download repository and run Evolve.Markets.xcworkspace in iOS 9.2+
It uses multiple frameworks using Pod so it only works if you run the workspace file.

# How to Use

## Create Evolve.Markets account
https://mt5.clients.evolve.markets/join/

## Login

<img src= "https://github.com/alextaoultsides/evolve.markets/blob/master/images/login.png" width="300" />

## Accounts View

#### When logged in, the accounts tab will be shown with all Live and Demo accounts tied to the user account:

<img src= "https://github.com/alextaoultsides/evolve.markets/blob/master/images/accounts.png" width="300" />
For live accounts you must use 

### Link to Webtrader is provided but can not autofill account info due to iOS app to app limitations

## Live Accounts
Live account settings may be changed by pressing settings button.  Live accounts can not be deleted.
Deposits and withdrawals on live accounts must be made through website.  Clicking on either button will prompt user to be redirected to their default web browser.


## Demo Accounts
 Deposit button prompts user for amount.
Remove button prompts user for deletion of account
Change settings and even delete account through 

<img src= "https://github.com/alextaoultsides/evolve.markets/blob/master/images/addFunds.png" width="300" />

## Account Settings

<img src= "https://github.com/alextaoultsides/evolve.markets/blob/master/images/accountSetting.png" width="300" />

Change name, set leverage, set account type and delete demo account
Must press save to commit changes 


## User Settings Tab
Set E-mail notifications by changing the status of the switches

<img src= "https://github.com/alextaoultsides/evolve.markets/blob/master/images/userSetting.png" width="300" />

## History Tab
View successful logins and failed attempts through iOS device.  Login history is presisted to device using CoreData

<img src= "https://github.com/alextaoultsides/evolve.markets/blob/master/images/history.png" width="300" />


# License Information

Evolve.Markets
https://evolve.markets/

## Frameworks Used

### Alamofire
https://github.com/Alamofire/Alamofire

### AlamofireObjectMapper
https://github.com/tristanhimmelman/AlamofireObjectMapper

### ObjectMapper
https://github.com/Hearst-DD/ObjectMapper/

### SCLAlertView
https://github.com/vikmeup/SCLAlertView-Swift

### AlamofireNetworkActivityIndicator
https://github.com/Alamofire/AlamofireNetworkActivityIndicator
