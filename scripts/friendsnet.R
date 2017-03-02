# Matrix of followers/friends of a given twitter account
# --------------------
friendsnet <- function(tuser) {
  require(twitteR)
  
  # if rate limit is hit, wait for 15 minutes
  limit <- getCurRateLimitInfo()[53,3]
  print(paste("Look up limit", limit))
  if (limit == 0) {
    print("sleeping for fifteen minutes")
    Sys.sleep(900)
  }
  
  # Find user
  tuser <- getUser(tuser)
  print(tuser$screenName)
  
  # Empty dataframe
  df <- NULL
  print("empty data frame")
  
  # Get names of friends
  f <- lookupUsers(tuser$getFriendIDs())
  f.id <- sapply(f, id)
  f.name <- sapply(f, screenName)
  f2 <- as.data.frame(cbind(f.id, f.name))
  print("list of friends")
  print(head(f2))
  limit <- 15
  
  for (i in f2$f.name) {
    
    # if rate limit is hit, wait for 15 minutes
    limit <- limit - 1
    
    print(paste("Look up limit", limit))
    if (limit == 0) {
      limit <- 15
      print("sleeping for fifteen minutes")
      Sys.sleep(900)
    }
    A <- getUser(i)
    friends.object <- lookupUsers(A$getFriendIDs())
    # Convert list into data frame
    friends.id <- sapply(friends.object,id)
    friends.name <- sapply(friends.object, screenName)
    friends <- as.data.frame(cbind(friends.id, friends.name))
    
    for (j in f2$f.name) {
      if (i != j) {
        if ((j %in% friends$friends.name) == TRUE) {
          print(paste(i, "sigue a", j))
          df <- rbind(df, data.frame(i, j))
        }
      }
      
    }
    
  }
  return(df)
}
