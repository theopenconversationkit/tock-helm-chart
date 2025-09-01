# Helm Chart for Tock  (theopenconversationkit)


[Tock](https://doc.tock.ai/fr/), an open conversational AI platform provide a complete solution to build conversational agents aka bots.

Tock can integrate and experiment with both classic and Generative AI (LLM, RAG) models.


## Quick start

```console 
$ helm install mytock ./charts/tock
```

## DLDR

```console
$ helm install my-release oci://registry.hub.docker.com/onelans/tock --version 0.5.5
```

or

```console
helm repo add tock https://theopenconversationkit.github.io/tock-helm-chart/
helm repo update
helm search repo tock
helm install tock tock/tock --version 0.5.5
```

You will find more information on chart parameters at the helm chart [README](charts/tock/README.md).

## What is deployed 

The chart deploy all tock components. It's able also to deploy a mongodb database (Bitnami mongoDb chart is used as subchart) or use an existing mongodb backend. In the same feeling, since version 24.3.2 of tock, opensearch can be deployed as sub chart (opensearch chart is used as subchart) and since version 24.9.3 PGvector can be deployer as sub chart (bitnami chart is used as subchart).

![Tock on K8S](tock-24x-on-k8s.png)
