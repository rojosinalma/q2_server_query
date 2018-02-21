require 'socket'
require 'timeout'

module Q2ServerQuery
  class Client
    attr_reader :socket, :raw_response, :response, :hostname, :port, :header, :players_list

    def initialize(hostname, port)
      @socket   = UDPSocket.new
      @hostname = hostname
      @port     = port
      @header   = "\xff\xff\xff\xffstatus\x00"
    end

    def status
      @response = status_query.first.split("\\")
      header    = @response.shift

      return if @response.nil? || header[4..8] != "print"

      build_status(@response)
    end

    private

    def build_status(unparsed_info)
      basic_info       = {}
      unparsed_players = nil

      loop do
        key   = unparsed_info.shift
        value = unparsed_info.shift

        if value.include? "\n"
          unparsed_players = value.split("\n")
          value            = unparsed_players.delete_at(0)
          basic_info[key]  = value
          break
        else
          basic_info[key] = value
        end
      end

      @players_list = build_players(unparsed_players)

      basic_info.merge(players: @players_list).with_indifferent_access
    end

    def build_players(players)
      list = []
      players.each do |player|
        player_info = player.split(" ")
        h = {
          frags: player_info.shift,
          ping:  player_info.shift,
          name:  player_info.shift.delete('\\"')
        }

        list.push h
      end

      list
    end

    def status_query
      begin
        @raw_response = nil
        socket.send(header, 0, hostname, port)

        Timeout.timeout(5) do
          @raw_response = socket.recvfrom(1000)
        end
      rescue Timeout::Error
        Rails.logger.warning "-- Server #{hostname}:#{port} timed out!"
      end

      @raw_response
    end
  end
end
