FROM alpine/helm

LABEL version="0.1.0"
LABEL repository="https://github.com/igabaydulin/helm-check-action"
LABEL maintainer="Igor Gabaydulin"

LABEL com.github.actions.name="helm check action"
LABEL com.github.actions.description="Checks if helm's templates are valid"
LABEL com.github.actions.icon="cloud"
LABEL com.github.actions.color="blue"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint.sh"]

