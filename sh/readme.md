
生成 API 代码

```shell
goctl api go -api shorturl.api -dir .
```

启动 API

```shell
go run shorturl.go -f etc/shorturl-api.yaml
```

生成 RPC 代码

```shell
cd ../rpc/transform && goctl rpc protoc transform.proto --go_out=. --go-grpc_out=. --zrpc_out=.
```

安装运行 ETCD

```shell
sh ./etcd.sh
```

启动 RPC

```shell
cd ../rpc/transform && go run transform.go -f etc/transform.yaml
```


生成 Model

```shell
goctl model mysql ddl -c -src shorturl.sql -dir .

goctl model pg datasource -c -t shorturl --url="postgres://go-zero:mjXD5K5ckxBrsmjp@127.0.0.1:5432/go-zero?sslmode=disable" --dir .
```


一些问题：

- 使用 pgx 做数据驱动的时候，DataSource 需携带 postgres:// 协议头

相关错误提示：

```shell
cannot parse `go-zero:xxxxxx@127.0.0.1:5432/go-zero`: failed to parse as keyword/value (invalid keyword/value)
```

- 使用 redis 做缓存的时候，如果 redis 有密码需要配置上

相关错误提示：

```shell
{"@timestamp":"2025-09-29T22:04:39.794+08:00","caller":"clientinterceptors/durationinterceptor.go:35","content":"fail - etcd:/localhost:2379/transform.rpc/transform.transformer/expand - shorten:\"b0434f\" - rpc error: code = Unknown desc = NOAUTH Authentication required.","duration":"1.2ms","level":"error","span":"ee9a8991508ef346","trace":"311b02a7b0aa531113cf07b0b43f3ea7"}
```