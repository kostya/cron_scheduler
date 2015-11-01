# CronScheduler

Simple job scheduler with crontab patterns for Crystal Language.

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  cron_scheduler:
    github: kostya/cron_scheduler
```


## Usage


```crystal
require "cron_scheduler"
require "logger"

L = Logger.new STDOUT

CronScheduler.define do

  # normal crontab syntax, 5 tokens (minute, hour, day, month, wday)

  at("* * * * *") { L.info "every 1 minute" }
  at("*/5 20-23 * * *") { L.info "every 5 minutes between 20-23 hours" }
  at("*/2 */3 * * *") { L.info "every 2 minute every 3 hours" }
  at("45 * * * *") { L.info "every hour at :45" }
  at("* * * * SUN") { L.info "every 1 minute in sunday" }

  # I added extra syntax, when 6 tokens, first one parsed as seconds
  # (second, minute, hour, day, month, wday)

  at("*/3 * * * * *") { L.info "every 3.seconds" }
  at("20-45/5 * * * * *") { L.info "every 5.seconds between 20-45" }
end

L.info "Scheduler started"

sleep

```

## Crontab Format

![Eye](http://www.webenabled.com/sites/default/files/crontab-syntax.gif)
