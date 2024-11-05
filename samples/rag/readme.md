# Using Rag 

## Start ollama inside K8S cluster

```shell
helm repo add ollama-helm https://otwld.github.io/ollama-helm/
helm repo update
helm install ollama ollama-helm/ollama -f ./values-ollama-no-cpu.yaml
```

## Start pgadmin4 UI (if need)

Ref: https://artifacthub.io/packages/helm/runix/pgadmin4

```shell
helm repo add runix https://helm.runix.net
helm repo update
helm install pgadmin4 runix/pgadmin4 -f ./values-pgadmin.yaml 
```

> Default pgadmin login/pass are `chart@domain.com/SuperSecret`
> Postgres uri is :  `<helm-release-name>-postgresql`
> Postgres port : `5432`
> Postgres database : `postgres`
> Postgres user: `postgres`
> Postgres password can be found in Secret `<helm-release-name>-postgresql`


## Import data's

You can use Open Search or PGVector as vectorial backend

## Import data's in PGVector database

todo

## Import data's in OpenSearch database

todo