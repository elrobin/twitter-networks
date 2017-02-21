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