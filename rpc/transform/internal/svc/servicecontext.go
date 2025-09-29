package svc

import (
	_ "github.com/jackc/pgx/v5/stdlib"
	"github.com/zeromicro/go-zero/core/stores/sqlx"
	"shorturl/rpc/transform/internal/config"
	"shorturl/rpc/transform/model"
)

type ServiceContext struct {
	Config config.Config
	Model  model.ShorturlModel
}

func NewServiceContext(c config.Config) *ServiceContext {
	return &ServiceContext{
		Config: c,
		Model:  model.NewShorturlModel(sqlx.NewSqlConn("pgx", c.DataSource), c.Cache),
	}
}
