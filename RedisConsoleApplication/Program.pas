namespace RedisConsoleApplication;

uses
  StackExchange.Redis;
type
  Program = class
  public

    class method Main(args: array of String): Int32;
    begin
      var redis := ConnectionMultiplexer.Connect('localhost:6379');

      var db := redis.GetDatabase;

      db.StringSet('myKey','someValue 2',new TimeSpan(0,0,10));

      var value := db.StringGet('myKey');

      if(assigned(value))then
      begin
        Console.WriteLine($'value is {value}');
      end
      else
      begin
        Console.WriteLine('No value');
      end;

      Console.WriteLine('Press any key to stop...');
      Console.ReadLine;


    end;

  end;

end.