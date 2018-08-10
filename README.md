# html_to_ssml

Converts an HTML into an SSML file.

## Install

```
gem install bundler
bundle install
```

## Converting HTML to SSML

### Output to the terminal
```
./html_to_ssml examples/vox_ban_alex_jones.html
curl https://www.wired.co.uk/article/whats-driving-elon-musk | ./html_to_ssml
```

### Save to a file
```
./html_to_ssml examples/vox_ban_alex_jones.html > output.ssml
```
