# syntax=docker/dockerfile:1.7
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Base tools: curl for installation, git+jq for ralph, ca-certificates for TLS
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    git \
    gzip \
    jq \
    lsof \
    nano \
    openssh-client \
    tzdata \
    unzip \
    xz-utils \
  && rm -rf /var/lib/apt/lists/*

# Node.js (LTS) installation for Claude Code
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
  && apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/*

# Playwright/Chromium system dependencies
RUN npx playwright install-deps chromium

# Non-root user (better for working in /workspace)
ARG USERNAME=agent
ARG UID=1000
ARG GID=1000
RUN set -eux; \
    # if GID exists, use its name; otherwise create group USERNAME with this GID
    if getent group "${GID}" >/dev/null; then \
        EXISTING_GROUP="$(getent group "${GID}" | cut -d: -f1)"; \
        echo "GID ${GID} already exists as group ${EXISTING_GROUP}"; \
        GROUP_NAME="${EXISTING_GROUP}"; \
    else \
        groupadd -g "${GID}" "${USERNAME}"; \
        GROUP_NAME="${USERNAME}"; \
    fi; \
    \
    # if UID exists, don't overwrite; just ensure user USERNAME exists (or use existing)
    if getent passwd "${UID}" >/dev/null; then \
        EXISTING_USER="$(getent passwd "${UID}" | cut -d: -f1)"; \
        echo "UID ${UID} already exists as user ${EXISTING_USER}"; \
        # if user USERNAME doesn't exist, create with fallback UID but same group
        if ! id -u "${USERNAME}" >/dev/null 2>&1; then \
            useradd -m -g "${GROUP_NAME}" -s /bin/bash "${USERNAME}"; \
        fi; \
    else \
        # UID is free -> create user with exact UID and given group
        useradd -m -u "${UID}" -g "${GROUP_NAME}" -s /bin/bash "${USERNAME}"; \
    fi

# Workspace
RUN mkdir -p /workspace && chown -R ${UID}:${GID} /workspace
WORKDIR /workspace

# Entrypoint for skills initialization on first run (as root)
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER ${USERNAME}
ENV HOME=/home/${USERNAME}

# Add typical install locations to PATH
ENV PATH="${HOME}/.local/bin:${HOME}/.cargo/bin:${HOME}/.bun/bin:${HOME}/bin:${PATH}"

# Claude Code CLI (installs to ~/.local/bin)
RUN curl -fsSL https://claude.ai/install.sh | bash

# Ralph alias (installation happens in entrypoint.sh to preserve mounted volume)
RUN echo 'alias ralph="${HOME}/.local/share/ralph/ralph.sh --tool claude"' >> ${HOME}/.bashrc

# Optional: show tool versions in build output (won't fail if something doesn't print)
RUN (command -v claude && claude --version) || true \
 && (command -v ralph && ralph --help | head -n 5) || true

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]
