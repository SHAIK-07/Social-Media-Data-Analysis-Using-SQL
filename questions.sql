
-- 1,Find the number of users who have posted at least once.
SELECT COUNT(DISTINCT(user_id)) AS user_post_at_least_one FROM social_media.post;


-- 2,Count the number of likes each post has received.
SELECT post_id, COUNT(post_id) AS no_of_likes 
FROM social_media.post_likes
GROUP BY post_id;


-- 3,For each user, calculate the total number of followers they have.
SELECT followee_id AS user_id, COUNT(follower_id) AS no_of_followers 
FROM social_media.follows
GROUP BY followee_id;


-- 4, Most Followed Hashtag
SELECT hashtag_name AS 'Hashtags', COUNT(hashtag_follow.hashtag_id) AS 'Total Follows' 
FROM hashtag_follow, hashtags 
WHERE hashtags.hashtag_id = hashtag_follow.hashtag_id
GROUP BY hashtag_follow.hashtag_id
ORDER BY COUNT(hashtag_follow.hashtag_id) DESC LIMIT 5;

-- 5, Most Used Hashtags
SELECT hashtag_name AS 'Trending Hashtags', COUNT(post_tags.hashtag_id) AS 'Times Used'
FROM hashtags,post_tags
WHERE hashtags.hashtag_id = post_tags.hashtag_id
GROUP BY post_tags.hashtag_id
ORDER BY COUNT(post_tags.hashtag_id) DESC LIMIT 10;


-- 6, Most Inactive User
SELECT user_id, username AS 'Most Inactive User'
FROM users
WHERE user_id NOT IN (SELECT user_id FROM post);

 
-- 7, Most Likes Posts
SELECT post_likes.user_id, post_likes.post_id, COUNT(post_likes.post_id) 
FROM post_likes, post
WHERE post.post_id = post_likes.post_id 
GROUP BY post_likes.post_id
ORDER BY COUNT(post_likes.post_id) DESC ;

-- 8, Average post per user
SELECT ROUND((COUNT(post_id) / COUNT(DISTINCT user_id) ),2) AS 'Average Post per User' 
FROM post;

-- 9, no. of login by per user
SELECT user_id, email, username, login.login_id AS login_number
FROM users 
NATURAL JOIN login;


-- 10, User who liked every single post (CHECK FOR BOT)
SELECT username, Count(*) AS num_likes 
FROM users 
INNER JOIN post_likes ON users.user_id = post_likes.user_id 
GROUP  BY post_likes.user_id 
HAVING num_likes = (SELECT Count(*) FROM   post); 

-- 11,User Never Comment 
SELECT user_id, username AS 'User Never Comment'
FROM users
WHERE user_id NOT IN (SELECT user_id FROM comments);

-- 12, User who commented on every post (CHECK FOR BOT)
SELECT username, Count(*) AS num_comment 
FROM users 
INNER JOIN comments ON users.user_id = comments.user_id 
GROUP  BY comments.user_id 
HAVING num_comment = (SELECT Count(*) FROM comments); 


-- 13, User Not Followed by anyone
SELECT user_id, username AS 'User Not Followed by anyone'
FROM users
WHERE user_id NOT IN (SELECT followee_id FROM follows);

-- 14, User Not Following Anyone
SELECT user_id, username AS 'User Not Following Anyone'
FROM users
WHERE user_id NOT IN (SELECT follower_id FROM follows);

-- 15, Posted more than 5 times
SELECT user_id, COUNT(user_id) AS post_count FROM post
GROUP BY user_id
HAVING post_count > 5
ORDER BY COUNT(user_id) DESC;


-- 16, Followers > 40
SELECT followee_id, COUNT(follower_id) AS follower_count FROM follows
GROUP BY followee_id
HAVING follower_count > 40
ORDER BY COUNT(follower_id) DESC;


-- 17, Any specific word in comment
SELECT * FROM comments
WHERE comment_text REGEXP'good|beautiful';


-- 18, Longest captions in post
SELECT user_id, caption, LENGTH(post.caption) AS caption_length FROM post
ORDER BY caption_length DESC LIMIT 5;

-- 19,For each user, calculate the total number of people they follow.
SELECT follower_id, COUNT(followee_id) AS no_of_followee 
FROM social_media.follows
GROUP BY follower_id;

-- 20,List users who have logged in within the past 30 days
SELECT user_id 
FROM social_media.login
WHERE login_time BETWEEN DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND CURDATE();



-- 21,Find the top 10 most used hashtags in posts.

SELECT h.hashtag_name, COUNT(p.hashtag_id) AS usage_count 
FROM social_media.post_tags p
INNER JOIN social_media.hashtags h ON p.hashtag_id = h.hashtag_id
GROUP BY h.hashtag_name
ORDER BY usage_count DESC
LIMIT 10;


-- 22,Identify the top 10 users with the most followers.

WITH cte1 AS (
    SELECT followee_id, COUNT(follower_id) AS follower_count 
    FROM social_media.follows
    GROUP BY followee_id
    ORDER BY follower_count DESC
    LIMIT 10
)
SELECT u.username 
FROM social_media.users u
INNER JOIN cte1 c ON u.user_id = c.followee_id;


-- 23,Count how many photos and videos each user has posted.
WITH cte1 AS (
    SELECT p.user_id, COUNT(p.photo_id) AS no_of_photos 
    FROM social_media.post p
    INNER JOIN social_media.photos ph ON p.photo_id = ph.photo_id
    GROUP BY p.user_id
),
cte2 AS (
    SELECT p.user_id, COUNT(p.video_id) AS no_of_videos 
    FROM social_media.post p
    INNER JOIN social_media.videos v ON p.video_id = v.video_id
    GROUP BY p.user_id
)
SELECT u.user_id, COALESCE(c1.no_of_photos, 0) AS no_of_photos, COALESCE(c2.no_of_videos, 0) AS no_of_videos
FROM social_media.users u
LEFT JOIN cte1 c1 ON u.user_id = c1.user_id
LEFT JOIN cte2 c2 ON u.user_id = c2.user_id
ORDER BY u.user_id;


-- 24, Find the number of likes each user received on their posts, grouped by month.

SELECT p.user_id, MONTHNAME(pl.created_at) AS month_name, YEAR(pl.created_at) AS year, COUNT(pl.user_id) AS no_of_users_liked
FROM social_media.post p
INNER JOIN social_media.post_likes pl ON p.post_id = pl.post_id
GROUP BY p.user_id, year, month_name;


-- 25, Identify users who have commented on others’ posts more than 50 times.

SELECT c.user_id AS commented_user 
FROM social_media.post p
INNER JOIN social_media.comments c ON p.post_id = c.post_id
GROUP BY commented_user
HAVING COUNT(p.post_id) > 50;


-- 26,For each user, find posts that they have both liked and bookmarked.
SELECT pl.user_id, pl.post_id
FROM social_media.post_likes pl
INNER JOIN social_media.bookmarks b ON pl.user_id = b.user_id AND pl.post_id = b.post_id;
