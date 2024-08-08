
up: down
    # Build kontainera
	docker build . \
		--file .docker/php/Dockerfile \
		--tag php-kubernetes-cluster/php:latest
	# Inštalácia závislosí
	docker run --rm -it \
		-v $$PWD/src:/var/www/html \
		php-kubernetes-cluster/php:latest \
		composer install
	# Tvorba klasteru
	kind create cluster --config kind.yaml
	# Spustime kontainer
	kind load \
		docker-image php-kubernetes-cluster/php:latest \
		--name php-kubernetes-cluster
	# Pripojime ingress
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
	# Spustime DB
	helm upgrade --install --wait php-kubernetes-cluster-db .helm/db
	# Spustame aplikaciu
	helm upgrade --install --wait php-kubernetes-cluster-app .helm/app

down:
	kind delete cluster --name php-kubernetes-cluster
