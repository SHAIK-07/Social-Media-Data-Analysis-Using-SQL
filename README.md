

# Social Media Data Analysis Using SQL

## Project Description
This project involves data analysis on a simulated social media platform using SQL. The dataset includes information on users, posts, hashtags, comments, likes, follows, and bookmarks. By querying this dataset, we aim to uncover insights about user engagement, content popularity, and interaction patterns, which can be valuable for understanding social media trends.

### Dataset Structure
The database consists of the following tables:

- **users**: Stores user information (ID, username, bio, etc.).
- **follows**: Stores follow relationships between users.
- **login**: Logs user login activity, including IP addresses and timestamps.
- **post**: Contains post information, including photos, videos, and captions.
- **photos** and **videos**: Details for each photo and video posted.
- **post_likes**: Tracks likes on posts.
- **comments** and **comment_likes**: Stores comments on posts and likes on comments.
- **bookmarks**: Tracks bookmarked posts by users.
- **hashtags** and **post_tags**: Manages hashtags associated with posts.
- **hashtag_follow**: Tracks hashtag follows by users.

### SQL Analysis Topics
This project is structured around a series of SQL queries designed to explore various aspects of the social media platform:

1. **Basic Queries**: Foundational queries to understand user activity, engagement, follower counts, and recent logins.
2. **Intermediate Queries**: Queries exploring hashtag usage, influencer ranking, content type analysis, and user engagement timelines.
3. **Advanced Queries**: In-depth queries to calculate engagement rates, analyze login patterns, track follower growth, and determine content virality.

### Example Queries
Some example queries covered in this project include:

- **Popular Hashtags**: Identify the top 10 most-used hashtags.
- **Top Influencers**: Identify users with the most followers.
- **User Content Types**: Count how many photos and videos each user has posted.
- **Frequent Commenters**: Identify users who have commented frequently on others’ posts.
- **Liked and Bookmarked Posts**: For each user, find posts that they have both liked and bookmarked.

### Installation and Setup
To run these SQL queries:

1. **Set up the database**: Import the dataset into your SQL database.
2. **Query Editor**: Use any SQL editor or command-line interface to execute the queries.

