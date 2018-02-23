require 'socket'
require 'timeout'

module Q2ServerQuery
  class Client
    attr_accessor :address, :port
    attr_reader   :socket, :raw_response, :parsed_response, :players_list

    def initialize(address, port)
      @socket   = UDPSocket.new
      @timeout  = 10
      @address  = address
      @port     = port
      @msg      = "\xff\xff\xff\xffstatus\x00"
    end

    def status
      response = status_query
      return nil if response.nil?

      @parsed_response = response.first.split("\\")
      response_header  = @parsed_response.shift[4..8]

      return if response_header != "print"

      build_status(@parsed_response)
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
        socket.send(@msg, 0, address, port)

        Timeout.timeout(@timeout) do
          @raw_response = socket.recvfrom(1000)
        end

        socket.close
      rescue => e
        puts "-- Error with server #{address}:#{port}. Reason: #{e}"
      ensure
        return @raw_response
      end
    end
  end
end
