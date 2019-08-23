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


      var someKey := $'cache:JOHN10-PC:SessionService:{Guid.NewGuid}';

      DoSomeExpiry(db,'myKey','some value');
      DoSomeExpiry(db,someKey,'some value 2');



    end;

    class method DoSomeExpiry(db:IDatabase;key:String; value:String);
    begin
      db.StringSet(key,value,new TimeSpan(0,0,10));
      Console.WriteLine($'set key is {key} value is {value}');

      var setValue := db.StringGet(key);

      if(assigned(setValue))then
      begin
        Console.WriteLine($'got value {setValue} for {key}');
      end
      else
      begin
        Console.WriteLine('No value');
      end;

    end;


  end;

end.