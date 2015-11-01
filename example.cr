require "./src/cron_scheduler"
require "logger"

L = Logger.new STDOUT

CronScheduler.define do
  at("* * * * *") { L.info "every 1 minute" }
  at("*/5 20-23 * * *") { L.info "every 5 minutes between 20-23 hours" }
  at("*/2 */3 * * *") { L.info "every 2 minute every 3 hours" }
  at("45 * * * *") { L.info "every hour at :45" }
  at("* * * * SUN") { L.info "every 1 minute in sunday" }

  # when 6 tokens, first parsed as seconds
  at("20-45/5 * * * * *") { L.info "every 5.seconds between 20-45" }
end

sleep
