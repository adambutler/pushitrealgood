# Push for Pusher

![_pushforpusher](https://cloud.githubusercontent.com/assets/1238468/6403257/ed2561a0-be05-11e4-9978-f01a41fa50f8.gif)

Build at the Simpleweb Pusher hacknight.

### Roadmap

- [More less hacky code](https://github.com/adambutler/pushitrealgood/commit/a49bfa5f998da0bd3cf2b5d91296c5a6c37a2f3b)
- Webhook support?
- Account managment
- App management
- UI improvements
- All the specs
- Test interface
- Logging

### Install

```
$ git clone git@github.com:adambutler/pushitrealgood.git
$ cd pushitrealgood
$ bundle install
```

## Converting Your Certificate

> Credit note: Taken from [APN on Rails](https://github.com/PRX/apn_on_rails)

Once you have the certificate from Apple for your application, export your key
and the apple certificate as p12 files. Here is a quick walkthrough on how to do this:

1. Click the disclosure arrow next to your certificate in Keychain Access and select the certificate and the key.
2. Right click and choose `Export 2 items…`.
3. Choose the p12 format from the drop down and name it `cert.p12`.

Now covert the p12 file to a pem file:

    $ openssl pkcs12 -in cert.p12 -out apple_push_notification.pem -nodes -clcerts

### Contributing

Contributions are welcome, please follow [GitHub Flow](https://guides.github.com/introduction/flow/index.html)

--

Built by [Adam Butler](http://lab.io) - iOS App by [Jamie Maddocks](http://chicken-studios.com)
