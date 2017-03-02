# Readme

Updated scripts for developing networks of users in Twitter. It requires the following info:

- `rtweet` package. Developed by [Michael W. Kearney](https://mkearney.github.io/). Get development version:

```
require("devtools")
devtools::install_github("mkearney/rtweet")
```

- Obtain and access token for accessing [Twitter API](https://apps.twitter.com/).

## List of scripts

- `tw_accounts.R`. Retrieves list of twitter users who follow and are followed by a given user.
- `tw_matrix.R`. Given a set of twitter accounts it creates a matrix of relations depending on who follows who.

## Old script

* `friendsnet(user)`: Search through list of people *User A* follows and indicate relation between them. Due to rate limit restrictions this function takes some time. Max rate limit is 15 for every 15 min.

This function uses the `twitteR` package available in CRAN and developed by [Jeff Gentry](https://github.com/geoffjentry). This library uses the REST API of Twitter. You are also required authentication via OAuth.

