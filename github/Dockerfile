FROM hashicorp/terraform:1.3.7

WORKDIR /tf

COPY github/*tf .

COPY entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]
