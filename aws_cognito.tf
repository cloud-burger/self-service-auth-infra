resource "aws_cognito_user_pool" "main" {
  name = "cloud-burger"

  password_policy {
    minimum_length    = 8
    require_uppercase = true
    require_numbers   = true
    require_symbols   = true
  }
}

resource "aws_cognito_user_pool_domain" "main_domain" {
  domain       = "cloud-burger"
  user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user_pool_client" "main_client" {
  name                                 = "cloud-burger-admin-app"
  user_pool_id                         = aws_cognito_user_pool.main.id
  allowed_oauth_flows_user_pool_client = true
  supported_identity_providers         = ["COGNITO"]
  callback_urls                        = ["http://localhost:9090/callback"]
  generate_secret                      = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes = [
    "email",
    "openid",
    "profile",
    "cloud-burger/customer_write",
    "cloud-burger/customer_read",
    "cloud-burger/product_read",
    "cloud-burger/product_write",
    "cloud-burger/product_delete",
    "cloud-burger/update_order"
  ]
}

resource "aws_cognito_resource_server" "main_resource_server" {
  user_pool_id = aws_cognito_user_pool.main.id
  identifier   = "cloud-burger"
  name         = "Recursos das rotas de administracao"

  scope {
    scope_name        = "customer_write"
    scope_description = "Criar clientes"
  }

  scope {
    scope_name        = "customer_read"
    scope_description = "Ler dados dos clientes"
  }

  scope {
    scope_name        = "product_read"
    scope_description = "Ler os dados dos produtos"
  }

  scope {
    scope_name        = "product_write"
    scope_description = "Inserir e editar produtos"
  }

  scope {
    scope_name        = "product_delete"
    scope_description = "Remover os produtos"
  }

  scope {
    scope_name        = "update_order"
    scope_description = "Alterar os dados de um pedido"
  }
}
