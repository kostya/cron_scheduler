require "./spec_helper"

describe CronScheduler do
  it "should define jobs" do
    CronScheduler.define do
      add("*/1 * * * *") { puts "every 1 minute" }
      add("*/5 20-23 * * *") { puts "every 5 minute between 20-23 hours" }
    end
  end

  it "custom add job" do
    CronScheduler.add("*/1 * * * *") { puts "every 1 minute" }
  end
end
