# Asana Digest

asana_digest is a command line application to fetch Asana tasks of the previous work day and sends the digest to configured Hipchat channel.

## Usage

Required environment variables:

- `ASANA_DIGEST_APIKEY`: API key for Asana
- `ASANA_DIGEST_PROJECT_ID`: Project ID(s) to get tasks from. Separate with comma.
- `ASANA_DIGEST_HIPCHAT_TOKEN`: API token for Hipchat messaging
- `ASANA_DIGEST_HIPCHAT_ROOM_NAME`: Room name (ID) for Hipchat messaging
```

Optional environment variables:

- `ASANA_DIGEST_ACTIVE_USERS`: User IDs to report tasks. Separate with comma. By default it will report all users in the project.


```
bundle install
bundle exec bin/asana_digest
```

## Screenshot

![](http://dl.dropbox.com/u/135035/Screenshots/i_bfp2zt3g-q.png)

## Author

Tatsuhiko Miyagawa
