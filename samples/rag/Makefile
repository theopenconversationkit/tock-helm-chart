
MOUNT_DATA=-v .:/datas
IMG=tock/llm-indexing-tools:24.9.3
SAMPLE_DATA=/datas/filtered_horror_movies.csv
CONFIG_IA=/datas/embedding-config-ollama.json
CONFIG_IA_IN_K8S=/datas/embedding-config-ollama-in-k8s.json
CONFIG_OPENSEARCH_STORE=/datas/opensearch-store.json
CONFIG_PGVECTOR_STORE=/datas/pgvector-store.json
# for ollowing Http acces to opensearch  tock_gen_ai_orchestrator_application_environment have to be set to dev
CONF_ENV=-e tock_gen_ai_orchestrator_application_environment=DEV


init-ollama:
	ollama serve &
	sleep 5
	ollama pull nomic-embed-text
	ollama pull tinyllama
	ollama list

stop-ollama:
	ollama stop nomic-embed-text
	ollama stop tinyllama
	pkill ollama -9
	
load-opensearchdata:
	docker pull tock/llm-indexing-tools:24.9.3
	kubectl port-forward svc/opensearch-cluster-master 9200:9200 &
	sleep 2
	docker run --rm -it ${CONF_ENV} ${MOUNT_DATA} ${IMG} python tock-llm-indexing-tools/index_documents.py ${SAMPLE_DATA} app new-assistant ${CONFIG_IA} ${CONFIG_OPENSEARCH_STORE} 200
	sleep 2
	pkill kubectl -9

load-pgvectordata:
	docker pull tock/llm-indexing-tools:24.9.3
	kubectl port-forward svc/mynewtock-postgresql 5432:5432 &
	sleep 2
	docker run --rm -it ${MOUNT_DATA} ${IMG} python tock-llm-indexing-tools/index_documents.py ${SAMPLE_DATA} app new-assistant ${CONFIG_IA} ${CONFIG_PGVECTOR_STORE} 200
	sleep 2
	pkill kubectl -9

load-pgvectordata-ollama:
	docker pull tock/llm-indexing-tools:24.9.3
	kubectl port-forward svc/mynewtock-postgresql 5432:5432 &
	sleep 2
	docker run --rm -it ${MOUNT_DATA} ${IMG} python tock-llm-indexing-tools/index_documents.py ${SAMPLE_DATA} app new-assistant ${CONFIG_IA_IN_K8S} ${CONFIG_PGVECTOR_STORE} 200
	sleep 2
	pkill kubectl -9


load-pgvectordata-lite:
	docker run --rm -it ${MOUNT_DATA} ${IMG} python tock-llm-indexing-tools/index_documents.py ${SAMPLE_DATA} app new-assistant ${CONFIG_IA} ${CONFIG_PGVECTOR_STORE} 200



