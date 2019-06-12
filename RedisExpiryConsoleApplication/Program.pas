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
          end);

        Console.WriteLine('Any key to exit');
        Console.ReadLine;
    end;

  end;

end.