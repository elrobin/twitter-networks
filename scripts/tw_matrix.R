# Script for creating matrices of follower/followee based on a list of twitter
# users.

# To use this script you need to connect to the OAth Twitter API and already 
# identified the community of users in a data frame using tw_accounts.R

tw_matrix <- function(nodes) {
  library(rtweet)
  df <- NULL  
  for (i in 1:length(nodes)) {

    # if rate limit is hit, wait for 15 minutes
    limit <- 15
    
    print(paste("Look up limit", limit))
    if (limit == 0) {
      limit <- limit - 1
      print("sleeping for fifteen minutes")
      Sys.sleep(60*15)
    }
  f.list <- NULL  
  A <- lookup_users(nodes[i,1]) # There is a bug here
    # Get list of friends
    if (A$friends_count<75001) {
      # print(tuser, " has less than 75000 friends")
      f.list <- get_friends(A$user_id)
    } else {
      rounds <- as.integer(A$friends_count)/75000
      n.rounds <- seq(1:rounds)
      f.list <- NULL
      for(m in n.rounds) {
        f <- get_friends(A$user_id, n = 75000, page = m)
        f.list <- rbind(f.list, f)
      }
    }
    B <- nodes$user_id
    for (j in 1:length(nodes)) {
      
      if (A$user_id != B[j,]) {
        if ((B[j,] %in% f.list$user_id) == TRUE) {
          print(paste(A$user_id, "follows", B[j,]))
          df <- rbind(df, data.frame(A$user_id, B[j,]))
        }
      
      }
    }
  
  print("Finished w user. Sleeping for 15 minutes")
  Sys.sleep(60*15)
  }
  return(df)
}