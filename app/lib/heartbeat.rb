module Heartbeat
  mattr_reader :queue

  HEARTBEAT_SLEEP = 0.1
  RANDOM_MAX = 15

  # Start background generation of random data in a thread
  def self.start!
    @hb = Thread.new do
      while(true) do
        queue_for_bulk_write
        sleep HEARTBEAT_SLEEP
      end
    end
  end

  # Stop background generation of random data
  def self.stop!
    return unless @hb && @hb.alive?
    @hb.kill
  end

  private

  def self.random_data
    (rand * RANDOM_MAX).round(4)
  end

  def self.queue_for_bulk_write
    @queue ||= []
    @queue << { value: random_data, generated_at: Time.now }

    write_records! if @queue.count == 50
  end

  def self.write_records!
    query_string = @queue.map {|i| "(#{i[:value]}, '#{i[:generated_at]}')"}.join(",")
    ActiveRecord::Base.connection.execute("INSERT INTO random_values (value, generated_at) VALUES #{query_string}")
    @queue = []
  end

end
