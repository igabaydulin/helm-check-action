FROM alpine/helm:2.16.0

LABEL version="0.1.5"
LABEL repository="https://github.com/igabaydulin/helm-check-action"
LABEL maintainer="Igor Gabaydulin"

LABEL com.github.actions.name="GitHub Action for Helm Templates Validation"
LABEL com.github.actions.description="Checks if helm templates are valid"
LABEL com.github.actions.icon="cloud"
LABEL com.github.actions.color="blue"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint.sh"]

