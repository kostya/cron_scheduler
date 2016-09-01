require "./spec_helper"

describe CronScheduler do
  it "should define jobs" do
    CronScheduler.define do
      at("*/1 * * * *") { }
      at("*/5 20-23 * * *") { }
    end
  end

  it "custom add job" do
    CronScheduler.at("*/1 * * * *") { }
  end

  it "run the jobs" do
    x = [] of Time
    CronScheduler.at("* * * * * *") { x << Time.now }
    sleep 2.5
    x.size.should be >= 2
    x.size.should be <= 3
  end

  it "stats" do
    CronScheduler.at("* * * * * *") { }
    s = CronScheduler.stats
    x = s.find { |c| c[:name] == "* * * * * *" }.not_nil!
    (x[:sleeping_for].as(Float64)).should be <= 1.0
  end
end
