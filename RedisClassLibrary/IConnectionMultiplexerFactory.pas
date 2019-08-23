namespace RedisClassLibrary;

uses
  StackExchange.Redis;

type

  IConnectionMultiplexerFactory = public interface
    method Connect(options:ConfigurationOptions):IConnectionMultiplexer;
    method Subscribe(options:ConfigurationOptions):ISubscriber;
    method MasterEndPoints(options:ConfigurationOptions): sequence of ConfigurationOptions;

  end;

end.