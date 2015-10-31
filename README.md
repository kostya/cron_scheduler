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
  add("*/1 * * * *") { L.info "every 1 minute" }
  add("*/5 20-23 * * *") { L.info "every 5 minute between 20-23 hours" }
  add("*/2 */1 * * *") { L.info "every 2 minute every 1 hour" }
  add("45 * * * *") { L.info "every hour at :45" }
  add("* * * * SUN") { L.info "every 1 minute in sunday" }
end

sleep
```

