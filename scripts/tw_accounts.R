# Script for retrieving networks from twitter friends data of a given user


tw_accounts <- function(tw_user) {
  require(rtweet)
  
  # if rate limit is hit, wait for 15 minutes
  limit <- rate_limit(twitter_token)[76,3]
  print(paste("Look up limit", limit))
  if (limit == 0) {
    print("sleeping for fifteen minutes")
    Sys.sleep(15*60)
  }
  
  # Find user
  tuser <- lookup_users(tw_user)
  
  # Get list of friends
  if (tuser$friends_count<75001) {
    # print(tuser, " has less than 75000 friends")
    f.list <- get_friends(tuser$user_id)
  } else {
    rounds <- as.integer(tuser$friends_count)/75000
    n.rounds <- seq(1:rounds)
    f.list <- NULL
    for(i in n.rounds) {
      f <- get_friends(tuser$user_id, n = 75000, page = i)
      f.list <- rbind(f.list, f)
    }
  }

  completefriends <- lookup_users(f.list)
  
  #Filter protected accounts
  completefriends <- subset(completefriends, subset = protected==FALSE)
  print("list of friends registered and filtered")
  
  # Look up for followers

    # if rate limit is hit, wait for 15 minutes
  limit <- rate_limit(twitter_token)[76,3]
  print(paste("Look up limit", limit))
  if (limit == 0) {
    print("sleeping for fifteen minutes")
    Sys.sleep(15*60)
  }
  
  # Get list of followers
  if (tuser$followers_count<75001) {
    # print(tuser$screen_name, " has less than 75000 followers")
    fol.list <- get_followers(tuser$user_id)
  } else {
    # print(tuser$screen_name, "has more than 75000 followers")
    rounds <- as.integer(tuser$followers_count)/75000
    n.rounds <- seq(1:rounds)
    fol.list <- NULL
    for(i in n.rounds) {
      fol <- get_followers(tuser$user_id, n = 75000, page = i)
      fol.list <- rbind(fol.list, fol)
    }
  }
  
  completefollowers <- lookup_users(fol.list)
  
  # Filter protected accounts
  completefollowers <- subset(completefollowers, subset = protected==FALSE)
  print("list of followers registered and filtered")
  
  # Keep only those which are in both lists

  allusers <- rbind(completefollowers, completefriends)
  allusers$dup <- duplicated(allusers)
  final.list <- subset(allusers, subset = dup==TRUE)
  return(final.list)
}
#   
#     A <- getUser(i)
#     friends.object <- lookupUsers(A$getFriendIDs())
#     # Convert list into data frame
#     friends.id <- sapply(friends.object,id)
#     friends.name <- sapply(friends.object, screenName)
#     friends <- as.data.frame(cbind(friends.id, friends.name))
#     
#     for (j in f2$f.name) {
#       if (i != j) {
#         if ((j %in% friends$friends.name) == TRUE) {
#           print(paste(i, "sigue a", j))
#           df <- rbind(df, data.frame(i, j))
#         }
#       }
#       
#     }
#     
#   }
#   return(df)
# }
