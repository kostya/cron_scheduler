require "cron_parser"

class CronScheduler
  VERSION = "0.1.0"

  @@patterns = {} of String => {CronParser, ->}

  def self.patterns
    @@patterns
  end

  def self.define(&block)
    with CronScheduler yield
  end

  def self.at(pattern, name = nil, &block : ->)
    parser = CronParser.new(pattern)
    @@patterns[(name || pattern).to_s] = {parser, block}

    spawn do
      loop do
        now = Time.now
        nxt = parser.next(now)
        sleep(nxt - now)
        spawn { block.call }
        sleep(0.0001)
      end
    end
  end

  def self.stats
    @@patterns.map do |k, v|
      parser = v[0]
      {:name => k, :next_execution_at => parser.next, :sleeping_for => (parser.next - Time.now).to_f}
    end
  end
end
