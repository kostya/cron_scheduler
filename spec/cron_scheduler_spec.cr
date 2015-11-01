require "./spec_helper"

describe CronScheduler do
  it "should define jobs" do
    CronScheduler.define do
      at("*/1 * * * *") { puts "every 1 minute" }
      at("*/5 20-23 * * *") { puts "every 5 minute between 20-23 hours" }
    end
  end

  it "custom add job" do
    CronScheduler.at("*/1 * * * *") { puts "every 1 minute" }
  end
end
