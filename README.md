# Sendcloud SMS
## Brief

`sendcloud-sms` an unofficial support for developers to send SMS with SendCloud API in Ruby. The gem packaged the official Restful API to a better ruby-style methods.

## Installation

For scaling projects using `bundler` to manage the gems, just add one line to your `Gemfile`

```ruby
gem 'sendcloud-sms'
```

And then execute in shell:

```shell
bundle
```

Or install it yourself via gem as:

```shell
gem install sendcloud-sms
```

## Getting Started

### Config

This gem is both rails friendly and pure ruby friendly. You could config the gem via the following three ways.

#### For Rails Developers

Create `config/initializers/sendcloud-sms.rb`

```ruby
SendCloud::SMS.auth('user', 'api_key')
```

It's ready to go.

#### For Other Developers

Add the following line before calling any method to send SMS.

```ruby
SendCloud::SMS.auth('user', 'api_key')
```

#### Using Config File

If you are in need of using seperated configuration of different environments. You could first create `config/sendcloud.yml` or whatever file you want with the following YAML.

```yaml
development:
  user: user for development
  api_key: api_key for development
production:
  user: user for production
  api_key: api_key for production
```

Load it before calling any other method

##### In Development

```ruby
SendCloud::SMS.load!('./config/sendcloud.yml', :development)
```

##### In Production

```ruby
SendCloud::SMS.load!('./config/sendcloud.yml', :production)
```

##### For Rails Developers

```ruby
SendCloud::SMS.load!('./config/sendcloud.yml', (Rails.env.development ? :development: :production))
```

### Send SMS

parameter `phone` could be either an array of phone numbers or one phone number

#### Usage:

```ruby
SendCloud::SMS.send(template_id, phone, vars)
```

#### Example:

```ruby
SendCloud::SMS.send(1234, '18000000000', {veri_code: '1234'})
SendCloud::SMS.send(4321, %w'18000000000 13800000000 13700000000', {broadcast: 'Hello SMS!'})
```

### Send Voice Message

The SendCloud Voice message is only available for verification code. What's more, it **does not** support receiving an array of phone numbers.

#### Usage:

```ruby
SendCloud::SMS.send_voice(phone, code)
```

#### Example:

```ruby
SendCloud::SMS.send_voice('18000000000', '1234')
```

### Return

The method returns an integer as code of response. Check the following list for details.

| Return Code | 含义                                       |
| ----------- | ---------------------------------------- |
| 200         | OK                                       |
| 311         | Parts of numbers delivered               |
| 411         | Phone number should not be empty         |
| 412         | Wrong phone numbers                      |
| 413         | Duplicated phone numbers                 |
| 421         | Bad signature parameter                  |
| 422         | Bad signature                            |
| 431         | Template not found                       |
| 432         | Template not examined yet                |
| 433         | Template ID is empty                     |
| 441         | Wrong parameters                         |
| 451         | Wrong sending time                       |
| 452         | Sending time has passed                  |
| 461         | Invalid Unix timestamp                   |
| 471         | smsUser not exist                        |
| 472         | smsUser is empty                         |
| 473         | No permission to send SMS                |
| 474         | User not found                           |
| 481         | Phone number or vars is empty            |
| 482         | Phone number or vars is invalid          |
| 483         | Vars longer than 32 chars                |
| 496         | Too many SMS for one phone number in one minute |
| 498         | Too many SMS for one phone number in one day |
| 499         | Out of balance                           |
| 501         | Server Error                             |

## Roadmap

- Support timing SMS
- Add spec to get 100% code covered
- Support SMS Hook