# Decription:
TearList is a social media platform for people to share with friends and communities their tier lists for various subjects. Tier lists on this app are constructed in the popular internet S through F format. TearList provides users with a chance to share their favorites, least favorites, hot-takes (hence the tears!), and mild-takes.  

# How to use:
1. Log in
2. View the explore page and find the newest profile/community posts
3. Join Communities to find tier lists about topics that interest you!
4. Make posts through the create page


# Routes

## Admin

### update_user() - POST
Update the user with the given username and email.
### get_users() - GET
Get all the users from the database.
### get_communities() - GET
Get all the communities from the database.
### update_community() - POST
Update the community with new name and description.


## User

### postLoginInfo() - POST
Takes in a username and password and returns the user's information if the login is successful.
### create_a_post() - POST
Create a post with the given (s, a, b, c, d, e, f) tiers, title, and description.
### get_followers() - GET
Get all the followers of the user with the given userID.
### get_following() - GET
Get all the users that the user with the given userIgitD is following.
### get_user_communities(userID) - GET
Get all the communities that this user is a member of.
### get_user_posts(userID) - GET
Get all the posts that this user has made.

## Community Leader

### get_members() - GET
Get all the members of the community with the given communityID.
### get_community_posts() - GET
Get all the posts that have been made in the community with the given communityID