{pkgs, ...}: {
  home.packages = with pkgs; [
    docker
    kubectl
    terraform
    trivy # container vulnerability scanner
    snyk # security scanning
    awscli
    gh
  ];
}
