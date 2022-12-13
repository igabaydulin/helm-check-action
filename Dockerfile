FROM alpine/helm:3.5.3

LABEL version="0.2.0"
LABEL repository="https://github.com/hopisaurus/helm-check-action"
LABEL maintainer="Hopisaurus"

LABEL com.github.actions.name="GitHub Action for Helm Templates Validation"
LABEL com.github.actions.description="Checks if helm templates are valid"
LABEL com.github.actions.icon="cloud"
LABEL com.github.actions.color="blue"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint.sh"]

