require "./src/cron_scheduler"
require "logger"

L = Logger.new STDOUT

CronScheduler.define do
  add("*/1 * * * *") { L.info "every 1 minute" }
  add("*/5 20-24 * * *") { L.info "every 5 minute between 20-24 hours" }
  add("*/2 */1 * * *") { L.info "every 2 minute every 1 hour" }
  add("45 * * * *") { L.info "every hour at :45" }
  add("* * * * SUN") { L.info "every 1 minute in sunday" }
end

sleep