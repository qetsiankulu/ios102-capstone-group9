Original App Design Project - Group 9
===

# TEMPORARY NAME: onTheSpot

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

[Provide a brief description of your app, its purpose, and functionality.]
OnTheSpot is an app for lifelong learners who want to join communities of likeminded people looking to challege themselves and improve their skills in a space where making mistakes is normalized. The main premise of the app is that each day, once you click on the room for a certian subject you are in, you will have 2 minutes to solve a problem and post your solution publically. Only once you have solved it can you see other's responses and give feedback. There will also be the option to join and create different rooms and room creators will have the option to set questions. 

### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:** [Education]
- **Mobile:** [Yes]
- **Story:**  [It puts users on the spot to anwser questions in a supportive community so that they can build confidence and learn from their mistakes ]
- **Market:** [lifelong learners, schools, academic clubs]
- **Habit:** [It is a daily app. Users will be encouraged to anwser the daily question once a day]
- **Scope:** [The feature to add rooms for different subjects allows it to be broad]

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
* User can view the different channels on the main feed after sign up or login
* option to create groups
* options for leader of group to set questions for the week
* options for participants in groups to anwser question of day ( they get 2 minutes to anwser once they open the app and only after they anwser can they see the feed of other responses for that room)
* ability to give feedback (comment section) on responses


**Optional Nice-to-have Stories**


### 2. Screen Archetypes
  [**Sign-in Screen**] - Qetsia 
* [Required User Feature: User can log in.]
* [Required User Feature: User can sign up.]


[**Signup Screen**] - Qetsia
* [Required User Feature: User can type in their email]
* [Required User Feature: User can type in their password]
* [Required User Feature: User can click a button that redirects them to the Login screen]
* [Required User Feature: User can click a 'X' that redirects them to the Home Screen]
* [Required User Feature: User can click a 'Continue' button that takes them to the Home Feed Screen]


[**Login Screen**] - Qetsia 
* [Required User Feature: User can type in their email]
* [Required User Feature: User can type in their password]
* [Required User Feature: User can click a button that signs them up through their Github account]
* [Required User Feature: User can click a button that redirects them to the Signup screen]
* [Required User Feature: User can click a 'X' that redirects them to the Home Screen]
* [Required User Feature: User can click a 'Continue' button that takes them to the Home Feed Screen]
[**Custom Room Screen**] - Sai Mannava 
* [Required User Feature: Based on the room the user clicks, call an API to display feed]
* [Required User Feature: Having a custom tailored questions for each room]
* [Optional User Feature: User can interact with other people in the screen]
* [Optional User Feature: The Room and the UI should be connected]


### 3. Navigation

**Tab Navigation** (Tab to Screen)


- [ ] [First Tab, e.g., Home Feed (where you see the rooms)]
- [ ] [Second Tab, e.g., Profile (maybe. We could also use this to manage your groups and delete groups)]
- [ ] [third tab, Create/Add Group]


**Flow Navigation** (Screen to Screen)

[**Sign-in Screen**] - Qetsia
  * Leads to [**Signup Screen**]
  * Leads to [**Login Screen**]
  
[**Signup Screen**] - Qetsia
  * Leads to [**Login Screen**]
  * Leads to [**Home Feed Screen**]
  
 [**Login Screen**] - Qetsia 
  * Leads to [**Signup Screen**]
  * Leads to [**Home Feed Screen**]

- [ ] [**home feed**]
  * Leads to [**individual room feeds**] 
 - [ ] [**individual room feeds**]
  * Leads to [**Question creation screen (for leader only)**] 
 - [ ] [**individual room feeds**]
  * Leads to [**Question anwser screen (for non-leader participants)**] 


## Wireframes
[**Sign-in Screen**] - Qetsia 
![Screenshot 2024-04-11 at 9.41.40 AM](https://hackmd.io/_uploads/rkm1mcHeC.png)

[**Signup Screen**] - Qetsia 
![signup ](https://hackmd.io/_uploads/rJIIBcSlA.png)


[**Login Screen**] - Qetsia 
![Screenshot 2024-04-11 at 9.49.41 AM](https://hackmd.io/_uploads/HkPTEqBgC.png)



![Screenshot 2024-04-12 at 1.31.58 PM](https://hackmd.io/_uploads/rkGUcMvgC.png)

(see bigger photo):
[link to photo](https://drive.google.com/file/d/1XB08leobC5-mNciZEe_IRtdgFabKcy_A/view)




### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 


### Models

[Model Name, e.g., User]
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| username | String | unique id for the user post (default field)   |
| password | String | user's password for login authentication      |
| ...      | ...    | ...                          


### Networking

- [List of network requests by screen]
- [Example: `[GET] /users` - to retrieve user data]
- ...
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
