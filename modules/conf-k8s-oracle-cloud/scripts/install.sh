echo "Install required packages"

apt update && apt install docker.io -y && snap install microk8s --classic --channel=1.23/stable

curl -LO “https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl”

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl