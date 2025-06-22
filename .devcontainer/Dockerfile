# Base image
FROM mcr.microsoft.com/devcontainers/base:jammy

COPY setup_build_environment_on_ubuntu_22.sh .
COPY install_build_dependencies.sh . 
COPY install_developer_tools.sh .
COPY install_formatting_tools.sh .
COPY requirements.txt .

RUN chmod +x setup_build_environment_on_ubuntu_22.sh
RUN chmod +x install_build_dependencies.sh install_developer_tools.sh install_formatting_tools.sh

RUN ./setup_build_environment_on_ubuntu_22.sh

ENV PATH="$PATH:/opt/cmake-4.0.1-linux-x86_64/bin/"
WORKDIR /workspace

CMD ["/bin/bash"]
