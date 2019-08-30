namespace RedisClassLibrary;

uses
  StackExchange.Redis;

type

  IConnectionMultiplexerFactory = public interface
    method Connect(options:ConfigurationOptions):IConnectionMultiplexer;
    method Subscribe(connectionMultiplexor:IConnectionMultiplexer):ISubscriber;
    method MasterEndPoints(options:ConfigurationOptions): sequence of ConfigurationOptions;

  end;

end.