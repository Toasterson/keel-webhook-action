# Keel Webhook Github Action

This Action runs can be used to notify [Keel](https://keel.sh) about docker image updates (using [Keel's webhook endpoint](https://keel.sh/v1/guide/documentation.html#Webhooks).

## Usage

Use this action in a workflow that publishes docker image. All parameters are mandatory so you can use it like this.
Define two secrets for the Basic Auth protecting your keel.

```yaml
- name: Send keel Notification
  uses: Toasterson/keel-webhook-action@master
  with: 
    image: "ghcr.io/repo/image"
    keel-username: ${{ secrets.KEEL_USERNAME }}
    keel-password: ${{ secrets.KEEL_PASSWORD }}
    image-tag: ${{ env.GITHUB_REF_SLUG }}
    keel-url: "https://keel.example.com/"
```

## Example Workflow

**Note:** No guarantee is given that these docker actions work so use the ones from the marketplace and simply place tag and name properly

```yaml
name: push
on: [push]

jobs:
  buildandpushdockerimage:
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - uses: actions/checkout@v2
      - name: Inject slug/short variables
        uses: rlespinasse/github-slug-action@v3.x
      - name: build docker image
        run: docker build -t "ghcr.io/repo/image:${TAG}"
        env:
          TAG: ${{ env.GITHUB_REF_SLUG }}
      - name: push docker image
        run: docker push -t "ghcr.io/repo/image:${TAG}"
        env:
          TAG: ${{ env.GITHUB_REF_SLUG }}
      - name: Send keel Notification
        uses: Toasterson/keel-webhook-action@master
        with: 
          image: "ghcr.io/repo/image"
          keel-username: ${{ secrets.KEEL_USERNAME }}
          keel-password: ${{ secrets.KEEL_PASSWORD }}
          image-tag: ${{ env.GITHUB_REF_SLUG }}
          keel-url: "https://keel.example.com/"
```
