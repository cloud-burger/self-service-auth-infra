# Self-Service Authentication

> Este repositório tem como objetivo criar uma infraestrutura básica na AWS utilizando Terraform como ferramenta de Infraestructure as Code (IaC). Ele inclui duas Lambdas e um API Gateway.

## Instalação e Configuração

Antes de utilizar os recursos deste repositório, assegure-se de ter o Terraform instalado em sua máquina. Você pode encontrar as instruções de instalação na [Documentação oficial do Terraform.](https://learn.hashicorp.com/tutorials/terraform/install-cli).

Após a instalação, configure suas credenciais da AWS utilizando as seguintes variáveis de ambiente:

- `AWS_ACCESS_KEY_ID`.
- `AWS_SECRET_ACCESS_KEY`.

## Componentes

- **lambda_autenticate**: Esta é uma função Lambda responsável por criar o token de autenticação (JWT).
- **lambda_authorizer**: Está é uma função Lambda que valida o token de autenticação em todas as requisições.

_Após a validação do JWT, o API Gateway encaminha as requisições autorizadas para o Amazon EKS._

## Variáveis de Ambiente

Além das variáveis de ambiente padrão do Terraform, você deve configurar a seguinte variável para personalizar o comportamento da infraestrutura:

- TF_VAR_jwt_secret: Valor do segredo JWT necessário para as Lambdas.

## Instrução de Uso

1. Clone este repositório.
2. Configure suas credenciais da AWS.
3. Defina as variáveis de ambiente necessárias, como `TF_VAR_jwt_secret`.
4. Inicialize o Terraform executando:

## Execução Local

Após configurar o ambiente local e definir as variáveis de ambiente necessárias, você pode aplicar as configurações do Terraform para criar o API Gateway e configurar as integrações:

```bash
terraform init
```

5. Visualize as alterações planejadas com:

```bash
terraform plan
```

6. Aplique as configurações e crie os recursos na AWS com:

```bash
terraform apply -var="TF_VAR_jwt_secret=******************"
```

Após a aplicação bem-sucedida, seu API Gateway estará pronto para receber e encaminhar requisições autorizadas para o Amazon EKS. Certifique-se de que todas as integrações estejam funcionando corretamente antes de colocar o ambiente em produção.
