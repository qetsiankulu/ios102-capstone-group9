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
- [x] User can sign up using GitHub
- [x] User can sign up using email/password
- [x] User can login using GitHub
- [x] User can login using email/password
- [x] User can sign out 
      
- [ ] users have option to subscribe/ unsubscribe to different rooms
- [ ] users can only see rooms they are subscribed to in their feed
- [ ] feed shows fun facts/ trivia for that subject 


**Optional Nice-to-have Stories**
- [x] User can view a carousel of app features in the app landing page 


### 2. Screen Archetypes
  [**Sign-in Screen**] - Qetsia 
* [Required User Feature: User can log in.]
* [Required User Feature: User can sign up.]


[**Signup Screen**] - Qetsia
* [Required User Feature: User can type in their email]
* [Required User Feature: User can type in their password]
* [Required User Feature: User can click a button that redirects them to the Login screen]
* [Required User Feature: User can click a 'Continue' button that takes them to the Home Feed Screen]


[**Login Screen**] - Qetsia 
* [Required User Feature: User can type in their email]
* [Required User Feature: User can type in their password]
* [Required User Feature: User can click a button that signs them up through their Github account]
* [Required User Feature: User can click a button that redirects them to the Signup screen]
* [Required User Feature: User can click a 'Continue' button that takes them to the Home Feed Screen]

[**Custom Room Screen**] - Sai Mannava 
* [Required User Feature: Based on the room the user clicks, call an API to display feed]
* [Required User Feature: Having a custom tailored questions for each room]
* [Optional User Feature: User can interact with other people in the screen]
* [Optional User Feature: The Room and the UI should be connected]


[**Add subscription  Screen**] - Darian Lee 
* [Required User Feature: user can see all possible rooms and search for a room]
* [Required User Feature: rooms that they are subscribed to are selected]
* [Required User Feature: user can unselect and select rooms to change subscription]

[**main feed  Screen**] - Darian Lee 
* [Required User Feature: user can see the rooms they are subscribed to]
* [Required User Feature: clicking a room leads to "custom room screen]


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


### Sprint 1 GIFs
- User can sign up using GitHub and using email/password. SignIn, SignUp, and Login Screens have been built out. Still having troubling with the Github third-party authentication working consistently.
<div>
    <a href="https://www.loom.com/share/03a4852bd0a54365aeec532b84cd3ea3">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/03a4852bd0a54365aeec532b84cd3ea3-with-play.gif">
    </a>
  </div>
- UI room feed layout [Darian]
<img style="max-width:300px;" src="Screenshot 2024-04-19 at 7.35.05 PM.png">


### Sprint 2 GIFs
- Onboarding screens and logic has been completed.
<div>
    <a href="https://www.loom.com/share/57ddcd9e1ba84068a40b9d556d2941bd">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/57ddcd9e1ba84068a40b9d556d2941bd-with-play.gif">
    </a>
</div>



### Models

[Model Name, e.g., User]
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| username | String | unique id for the user post (default field)   |
| password | String | user's password for login authentication      |
| ...      | ...    | ...                          

in progress 

### Networking

- [List of network requests by screen]
- [Example: `[GET] /users` - to retrieve user data]
- ...
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
