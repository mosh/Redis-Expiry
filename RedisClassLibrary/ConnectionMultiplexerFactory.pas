namespace RedisClassLibrary;

uses
  StackExchange.Redis;

type

  ConnectionMultiplexerFactory = public class(IConnectionMultiplexerFactory)
  public
    method Connect(options:ConfigurationOptions):IConnectionMultiplexer;
    begin
      exit StackExchange.Redis.ConnectionMultiplexer.Connect(options)
    end;

    method Subscribe(connectionMultiplexor: IConnectionMultiplexer): ISubscriber;
    begin
      exit connectionMultiplexor.GetSubscriber();
    end;

    method MasterEndPoints(options:ConfigurationOptions): sequence of ConfigurationOptions; iterator;
    begin
      var connectionMultiplexer := self.Connect(options);

      var endpoints := connectionMultiplexer.GetEndPoints(true);

      for each endPoint in endpoints do
        begin
        var server := connectionMultiplexer.GetServer(endPoint);
        if (not server.IsSlave)then
        begin
          var localOptions := options.Clone();
          localOptions.EndPoints.Clear();
          localOptions.EndPoints.Add(endPoint);

          yield localOptions;

        end;
      end;

    end;


  end;


end.