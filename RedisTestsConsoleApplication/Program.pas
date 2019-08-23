namespace RedisTestsConsoleApplication;

uses
  Moq,
  RedisClassLibrary, StackExchange.Redis;

type
  Program = class
  public

    class method Main(args: array of String): Int32;
    begin

      var factory := new Mock<IConnectionMultiplexerFactory>(MockBehavior.Strict);
      var subscriber := new Mock<ISubscriber>;

      var connectionString := 'localhost:6379';
      var options := ConfigurationOptions.Parse(connectionString);

      var service := new ExpiryService(ConnectionMultiplexerFactory := factory.Object, options := options);

      factory.Setup(f -> f.MasterEndPoints(options)).Returns([options]);
      factory.Setup(f -> f.Subscribe(options)).Returns(subscriber.Object);


      subscriber.Setup(s -> s.Subscribe(
        It.IsAny<RedisChannel>,
        It.IsAny<Action<RedisChannel,RedisValue>>, CommandFlags.None
        ))
        .Callback<RedisChannel, Action<RedisChannel,RedisValue>, CommandFlags >((channel, handler, flags) ->
              begin
                handler(channel, 'expired');
              end);


      service.Start;


    end;

  end;

end.