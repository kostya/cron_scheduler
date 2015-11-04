require "./src/cron_scheduler"
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
  at("11,22,33,44-60/2 * * * * *") { L.info "every 11,22,33,44-60/2 seconds" }
end

L.info "Scheduler started"

sleep
