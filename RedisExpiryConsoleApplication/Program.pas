namespace RedisExpiryConsoleApplication;

uses
  StackExchange.Redis;

type
  Program = class
  public

    class method Main(args: array of String): Int32;
    begin
      var redis := ConnectionMultiplexer.Connect('localhost:6379');

      var subscriber := redis.GetSubscriber;

      var expiredChannel := '__keyevent@0__:expired';

      subscriber.Subscribe(expiredChannel, (channel, value) ->
          begin
            Console.WriteLine($'Expired channel {channel} value {value}');
            /*
            if ((string)channel == "__keyspace@0__:users" && (string)value == "sadd")
            {
                // Do stuff if some item is added to a hypothethical "users" set in Redis
            }
            */
          end);

        Console.WriteLine('Any key to exit');
        Console.ReadLine;
    end;

  end;

end.