require "spec"
require "../src/cron_scheduler"

module Spec
  before_each do
    CronScheduler.clear
  end
end
