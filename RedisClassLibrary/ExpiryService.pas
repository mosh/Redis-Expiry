namespace RedisClassLibrary;

uses
  StackExchange.Redis;

type
  ExpiryService = public class
  public
    property ConnectionMultiplexerFactory:IConnectionMultiplexerFactory;
    property options : ConfigurationOptions;


    method Start;
    begin


      for each localOptions in ConnectionMultiplexerFactory.MasterEndPoints(options) do
        begin

        var subscriber := ConnectionMultiplexerFactory.Subscribe(localOptions);

          var expiredChannel := '__keyspace@0__:cache:JOHN10-PC:SessionService:*';

          subscriber.Subscribe(expiredChannel, (channel, value) ->
              begin
                Console.WriteLine($'Expired channel {channel} value {value}');
              end);

        end;

    end;

  end;

end.