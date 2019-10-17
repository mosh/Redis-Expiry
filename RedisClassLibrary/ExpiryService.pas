namespace RedisClassLibrary;

uses

  StackExchange.Redis,  System. Collections. Generic;

type

  ExpiryService = public class(IDisposable)
  private
    _connectionMultiplexerFactory:IConnectionMultiplexerFactory;
    _options:ConfigurationOptions;
    _connectionMultiplexors : List<IConnectionMultiplexer> := new List<IConnectionMultiplexer>;

  public

    constructor(connectionMultiplexerFactory:IConnectionMultiplexerFactory; options:ConfigurationOptions);
    begin
       _connectionMultiplexerFactory := connectionMultiplexerFactory;
       _options := options;
    end;

    method Start;
    begin


      for each localOptions in _connectionMultiplexerFactory.MasterEndPoints(_options) do
      begin

        var connectionMultiplexor := _connectionMultiplexerFactory.Connect(localOptions);

        var subscriber := _connectionMultiplexerFactory.Subscribe(connectionMultiplexor);

        var expiredChannel := '__keyspace@0__:cache:JOHN10-PC:SessionService:*';

        subscriber.Subscribe(expiredChannel, (channel, value) ->
            begin
              Console.WriteLine($'Expired channel {channel} value {value} at {DateTime.Now}');
            end);
        _connectionMultiplexors.Add(connectionMultiplexor);



      end;

    end;

  end;

end.