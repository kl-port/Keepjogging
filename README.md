Original App Design Project - README Template
===

# Keepjogging

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Start jogging now! Post and share your jogging pictures with the same group of users, who are into jogging. The users can sign up, log in, post, and comment on the app. It is easy to use and clean to explore. We recommend users like and comment on other users' posts. A daily record of jogging can stimulate users to have a positive feedback cycle when they are in an encouraging community.

### App Evaluation
- **Category:** Sport/ Social networking
- **Mobile:** This app is primarily designed for mobile phone users.
- **Story:** Give users a change to engage into the jogging community and keep a record of jogging.
- **Market:** Health and sport are hot markets that combining with social media will make a good impact.
- **Habit:** The app is designed to let users to have a good habit of jogging.
- **Scope:** The app tries to make users to have positive attitudes on jogging and have more future chances to share their futher physical information and personal attributes on the app.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Sign up/ log in functions
* Profiles for users
* Post feed for all users
* Comment and like for posts

**Optional Nice-to-have Stories**

* The user can choose to stay anonymous or not.
* Personalized jogging route recommendations
* Chat window
* Filter: Top space, hot discussion.
* Optional Shuffle Button (i.e. random space, etc)

### 2. Screen Archetypes

* Sign up/ log in
* Post feed
   * Comment and upvote
* Post create
* Profile
  * Photo
  * Username
  * Show days of jogging
* Setting
  * Delete account
  * Notification Switch
  * Language Switch

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Post Feed
* Profile
* Create Post

Optional:
* Jogging report
* Settings (Accesibility, Notification, General, etc.)


**Flow Navigation** (Screen to Screen)
* Forced Log-in -> Post Feed
* Post Feed -> Create Post
* Post Feed -> Comment Post/ Edit Post
* Profile -> Text field or photo profile to be modified. 

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://i.imgur.com/dhzd1e7.jpg" width=600>


## Schema 
### Models
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User| image author |
   | image         | File     | image that user posts |
   | caption       | String   | image caption by author |
   | likesCount    | Number   | number of likes for the post |
   | postCreatedAt | DateTime | date when post is created (default field) |
   | postUpdatedAt | DateTime | date when post is last updated (default field) |
   | days          | Number   | Continue Jogging days |
   | commentCreatedAt      | DateTime | date when comment is created (default field) |
   | CommentUupdatedAt     | DateTime | date when comment is last updated (default field) |
   
### Networking
#### List of network requests by screen
   - Sign in/up screen
      - (Create/POST) Create a new user object
      ``` swift
        const Users = Parse.Object.extend("Users");
        const user = new User();
        user.save()
        .then((user) => {
        // any logic to be executed after the object is saved.
            alert('New object created with objectId: ' + user.id);
        }, (error) => {
            alert('Failed to create new object, with error code: ' + error.message);
        });
        ```
   - Home Feed Screen
      - (Read/GET) Query all posts where user is author
        ```swift
         let query = PFQuery(className:"Post")
         query.whereKey("author", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
         ```
      - (Create/POST) Create a new like on a post
      ``` swift
        const Users = Parse.Object.extend("Users");
        const user = new User();
        cricket.set("like", true);
        user.save()
        .then((user) => {
        // any logic to be executed after the object is saved.
            alert('liked by ' + user.id);
        }, (error) => {
            alert('Failed to create like: ' + error.message);
        });
      ```
      - (Delete) Delete existing like
      ``` swift
      const User = Parse.Object.extend("User");
      const user = new User();
      user.unset("like");
      user.save();
      ```
      - (Create/POST) Create a new comment on a post
      ``` swift
        const Users = Parse.Object.extend("Users");
        const user = new User();
        cricket.set("Comment", comment);
        user.save()
        .then((user) => {
        // any logic to be executed after the object is saved.
            alert('Commented by ' + user.id);
        }, (error) => {
            alert('Failed to create comment: ' + error.message);
        });
        ```
      - (Delete) Delete existing comment
      ``` swift
      const User = Parse.Object.extend("User");
      const user = new User();
      user.unset("Comment");
      user.save();
      ```
   - Create Post Screen
      - (Create/POST) Create a new post object
      ``` swift
        const Users = Parse.Object.extend("Users");
        const user = new User();
        cricket.set("post", post);
        user.save()
        .then((user) => {
        // any logic to be executed after the object is saved.
            alert('Post created by ' + user.id);
        }, (error) => {
            alert('Failed to create post: ' + error.message);
        });
        ```
   - Profile Screen
      - (Delete) Delete account
      ``` swift
      const User = Parse.Object.extend("User");
      const user = new User();
      user.unset("User");
      user.save();
      ```
      - (Update/PUT) Update username 
      ``` swift
        const User = Parse.Object.extend("User");
        const user = new User();
        user.save()
        .then((user) => {
        user.set("Username", name);
        return user.save();
        });
      ```
      - (Update/PUT) Update user profile image
      ``` swift
        const User = Parse.Object.extend("User");
        const user = new User();
        user.save()
        .then((user) => {
        user.set("Image", image);
        return user.save();
        });
     ```
      - (Update/PUT) Change the language
     ``` swift
        const User = Parse.Object.extend("User");
        const user = new User();
        user.save()
        .then((user) => {
        user.set("language", language);
        return user.save();
        });
     ```
      - (Update/PUT) Notification switch
     ``` swift
        const User = Parse.Object.extend("User");
        const user = new User();
        user.save()
        .then((user) => {
        user.set("Notification", notification);
        return user.save();
        });
     ```
