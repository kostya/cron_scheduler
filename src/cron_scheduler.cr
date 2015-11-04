require "cron_parser"

class CronScheduler
  VERSION = "0.1.0"

  @@patterns = {} of String => CronParser

  def self.patterns
    @@patterns
  end

  def self.clear
    @@patterns.clear
  end

  def self.define(&block)
    with self yield
  end

  def self.at(pattern, name = nil, &block : ->)
    parser = CronParser.new(pattern)
    @@patterns[(name || pattern).to_s] = parser

    spawn do
      prev_nxt = Time.now - 1.minute
      loop do
        now = Time.now
        nxt = parser.next(now)
        nxt = parser.next(nxt) if nxt == prev_nxt
        prev_nxt = nxt
        sleep(nxt - now)
        spawn { block.call }
      end
    end
  end

  def self.stats
    @@patterns.map do |k, v|
      nxt = v.next
      {:name => k, :next_execution_at => nxt, :sleeping_for => (nxt - Time.now).to_f}
    end
  end
end
