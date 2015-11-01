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
      prev_nxt = Time.now - 1.minute
      loop do
        now = Time.now
        nxt, nxt_failsafe = parser.next(now, 2)
        nxt = nxt_failsafe if nxt == prev_nxt
        prev_nxt = nxt
        sleep(nxt - now)
        spawn { block.call }
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
