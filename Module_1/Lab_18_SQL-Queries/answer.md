use Ironhack_DB;

# 1. What are the different genres?
- weather
- utilities
- travel
- sports
- social networking
- shopping
- reference
- productivity
- photo & video
- news
- navigation
- music
- medical
- lifestyle
- health & fitness
- games
- food & drink
- finance
- entertainment
- education
- business
- book

# 2. Which is the genre with the most apps rated?
- games
- total ratings of 8 607 404

# 3. Which is the genre with most apps?
- games
- total no. of apps of 162

# 4. Which is the one with least?
- medical
- with only 1 app

# 5. Find the top 10 apps most rated.
- facebook : 2 974 676 total no. of atings
- pandora (music & radio) : 1 126 879 total no. of atings
- pinterest : 106 1624 total no. of atings
- bible : 985 920 total no. of atings
- angry birds : 824 451 total no. of atings
- fruit ninja classic : 698 516 total no. of atings
- solitaire : 679 055 total no. of atings
- pac-man : 508 808 total no. of atings
- calorie counter & diet tracker by myfitnesspal : 507 706 total no. of atings
- the weather channel: forecast, radar & alerts : 495 626 total no. of atings

# 6. Find the top 10 apps best rated by users.
select
- j&j official 7 minute workout
- fragment's note
- dragon island blue
- fieldrunners 2
- sworkit - custom workout for exercice & fitness
- pumped: bmx
- headspace
- timeshare+
- infect them all: vampires
- daily audio bible app

# 7. Take a look at the data you retrieved in question 5. Give some insights.
- Facebook is by far leading amongst the most rated apps (over no. of total apps)
- Gaming isn't really surprising as part of the most rated, especially seeing games :
    - like PacMan and Solitaire which are calssics,
    - Angry Birds and Fruit Ninja which are widely played around the globe after becoming viral
- Pandora as a music/radio app, is almost expected to be part of the list, since people who have phones are very likely to use such an app to listen to some music
- The fitness app is also almost expected, since users nowadays are getting more and more aware of their health
- phone users nowadays rely on their phones for a lot of things, and one of them is weather apps, it's easier to check weather on the app rather than reading the news or watching the television; it's more instantaneous and more often updated/refresh, and some even are based on real-time data
- bible has always been one of the most sold and read for decades already, and with the rise of technology, it's just natural for religious people to take advantage of the e-book apps to read chapters and verses during their free time, making it easier and practical rather than carrying the bible with them all the time. Same goes for bible studies and evangelism, it might be that some practice to use apps more and more.


# 8. Take a look at the data you retrieved in question 6. Give some insights.
- Health and Fitness apps are mostly the best rated apps by users
Game apps, again, are one of the best rated apps by users, at least from the Top 10
- Bible is also best rated, just as it is mostly rated by users, coming up at Top 4 of mostly rated, and top 10 amongst the best rated apps


# 9. Now compare the data from questions 5 and 6. What do you see?
- The fact that Facebook was leading the numbers in terms of the most rated app, it only recieves a low rating from the users, same thing for PacMan having a lot of ratings, yet not really well rated by players :
    - perhaps, depending on the year this data has been collected, new generations may not appreciate the game anymore as the old generations do, but were still willing to try at least
- Angry Birds and Fruit Ninja has been consistent, both having a good number of ratings received, as well as remaining at a very high user rating

# 10. How could you take the top 3 regarding both user ratings and number of votes?
- All 3 having the 5-stars have a very little number total ratings by users. There are few causes :
    - the 5-stars these apps recieved must be by the lack of users rating to envision the real quality of the app
    - or the apps are fairly new, so not enough users yet to rate
    - or the app is just doing really good
- Fragment's note in particular, is the most obvious of all, having only 1 rating -- whatever the user have rated, will be it's definite overall rate (until new users will rate) -- in this case, is a 5-star. So it could generate a biased results of the real experience, since every user is different (depending on their taste, their expectations, etc)

# 11. Do people care about the price of an app? Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?
- No, people doesn't really care about the price :
    - many apps who have a lot of user ratings were free, so naturally, people would be more incline to test it out
    - yet a lot of the apps are highly rated, over 4-stars with a lot od user ratings, and costs from 0 to 19.99€ (an outlier of education-based app of 249.99€ was found, with 4-star ratings and over 750 user ratings : proloquo2go - symbol-based AAC)


All in all, gaming is leading, followed by health apps, and social networking. Perhaps there's a lack of medical-based apps available in the market, which could explain the lack of data. Depending on the goal and objectives, we could use these data to either push more apps that are most selling/downloaded/rated etc; or develop more medical apps to provide services and facilatate processes between users and health centers/admins/etc.