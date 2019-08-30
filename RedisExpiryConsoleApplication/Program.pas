namespace RedisExpiryConsoleApplication;

uses
  RedisClassLibrary,
  StackExchange.Redis;

type


  Program = class
  public

    class method Main(args: array of String): Int32;
    begin

      var connectionString := 'localhost:6379';

      var options := ConfigurationOptions.Parse(connectionString);

      var service := new ExpiryService(new ConnectionMultiplexerFactory, options);

      service.Start;

      Console.WriteLine('Any key to exit');
      Console.ReadLine;
    end;

  end;




end.