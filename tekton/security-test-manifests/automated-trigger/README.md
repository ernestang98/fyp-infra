helm repo add traefik https://helm.traefik.io/traefik

helm repo update

helm install traefik traefik/traefik --create-namespace --namespace=traefik --values=traefik-values.yml

kubectl describe svc traefik -n traefik


helm install traefik traefik/traefik --create-namespace --namespace=traefik --values=traefik-values.yml

helm uninstall traefik --namespace=traefik

curl -L https://istio.io/downloadIstio > install.sh

chmod +x install.sh

./install.sh

sudo cp istio-1.16.0/bin/istioctl /bin

istioctl install --set profile=demo -y

kubectl label namespace default istio-injection=enabled