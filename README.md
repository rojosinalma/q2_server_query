# Q2ServerQuery

I got tired of finding workarounds to query Q2 Servers by using JS libraries or other language implementations, so I created this simple gem.

**NOTE: This works ONLY with Quake 2 servers, it's not adapted for other protocols, but it might work with game servers that use the same protocol**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'q2_server_query'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install q2_server_query

## Usage

```ruby
client = Q2ServerQuery::Client.new("your.serverhostname.com (or IP)", server_port)
client.status

# Using AQ2 Server as example.
=> {
 "*Q2Admin"=>"2.0~fa34812",
 "_admin"=>"some_admin_name",
 "actionversion"=>"TNG 2.81 2017-08-25 07abb71",
 "allitem"=>"0",
 "allweapon"=>"0",
 "capturelimit"=>"0",
 "cheats"=>"0",
 "ctf"=>"0",
 "deathmatch"=>"1",
 "dmflags"=>"768",
 "fraglimit"=>"0",
 "game"=>"action",
 "gamedate"=>"Feb 21 2018",
 "gamedir"=>"action",
 "gamename"=>"action",
 "hostname"=>"AQ2 Server",
 "items"=>"1",
 "mapname"=>"teamjungle",
 "maptime"=>"0:00",
 "matchmode"=>"0",
 "maxclients"=>"16",
 "needpass"=>"0",
 "port"=>"27910",
 "protocol"=>"34",
 "q2a_mvd"=>"1.6hau",
 "roundlimit"=>"10",
 "roundtimelimit"=>"2",
 "t1"=>"0",
 "t2"=>"0",
 "t3"=>"0",
 "teamplay"=>"1",
 "tgren"=>"1",
 "timelimit"=>"20",
 "use_3teams"=>"0",
 "use_tourney"=>"0",
 "uptime"=>"1+2:24.11",
 "players"=>[
    {"frags"=>"99", "ping"=>"99", "name"=>"some_player"},
    {"frags"=>"99", "ping"=>"99", "name"=>"another_player"}
 ]
}
```

## Development

1. Fork it.
2. Do your thang.
3. Push a PR.
4. Ping me.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elfenars/q2_server_query.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
