# A quick class to parse the log lines
# May 31 20:46:24 ams25 solana-rpc.sh[49084]: [2022-05-31T20:46:24.161879078Z INFO  solana_core::replay_stage] new fork:135888573 parent:135888571 (leader) root:135888527
# May 31 20:46:24 ams25 solana-rpc.sh[49084]: [2022-05-31T20:46:24.455250990Z INFO  solana_core::replay_stage] bank frozen: 135888573
# May 31 20:46:24 ams25 solana-rpc.sh[49084]: [2022-05-31T20:46:24.539460696Z INFO  solana_core::replay_stage] voting: 135888573 0
class TX
  attr_reader :log_string, :slot, :parent, :timestamp

  def initialize(log_line)
    @log_line = log_line
  end

  def parse_new_fork
    # Используем регулярное выражение для гибкого парсинга
    slot_match = @log_line.match(/new fork:(\d+)/)
    @slot = slot_match[1].to_i if slot_match
    parent_match = @log_line.match(/parent:(\d+)/)
    @parent = parent_match[1].to_i if parent_match
    timestamp_match = @log_line.match(/\[(.*?)\s+INFO/)
    @timestamp = Time.parse(timestamp_match[1]) if timestamp_match
  end

  def parse_frozen
    slot_match = @log_line.match(/bank frozen:\s*(\d+)/)
    @slot = slot_match[1].to_i if slot_match
    timestamp_match = @log_line.match(/\[(.*?)\s+INFO/)
    @timestamp = Time.parse(timestamp_match[1]) if timestamp_match
  end

  def parse_voting
    # Парсим слот после 'voting:', игнорируя, что идёт дальше
    slot_match = @log_line.match(/voting:\s*(\d+)/)
    if slot_match
      @slot = slot_match[1].to_i
    else
      puts "WARNING: Could not parse slot in voting line: #{@log_line}"
      @slot = nil
    end
    timestamp_match = @log_line.match(/\[(.*?)\s+INFO/)
    @timestamp = Time.parse(timestamp_match[1]) if timestamp_match
  end
end
