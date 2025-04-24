
#!/bin/bash
function INSTALL_K8S_TOOLS {

  # Install kubectl
  if ! command -v kubect > /dev/null; then
    curl -sLo ~/.local/bin/kubectl \
      "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

    chmod +x ~/.local/bin/kubectl
  fi

  # Install Kind
  if ! command -v kind > /dev/null; then
    curl -sLo ~/.local/bin/kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-amd64;
    chmod +x ~/.local/bin/kind
  fi

  # Install k9s
  if ! command -v k9s > /dev/null; then
    k9s_deb=k9s_linux_amd64.deb
    k9s_url=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest \
      | jq -r '.assets[] | select(.name == "'${k9s_deb}'") | .browser_download_url')
    curl -sLO ${k9s_url} \
      && sudo dpkg -i ${k9s_deb} \
      && rm ${k9s_deb};
  fi

}
