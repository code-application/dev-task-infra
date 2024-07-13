# lp-infra

## インフラ初期設定

1. Terraform のインストール
2. kubectl のインストール
3. gcloud のインストール
4. [gcloud の設定変更](#gcloud-の設定変更)
5. [Project の作成](#project-の作成)
6. [terraform 用サービスアカウント作成(gcloud から)](#terraform-用サービスアカウント作成gcloud-から)
7. [GCE, GKE の API を有効にする](#gce-cloud-run-gcs-の-api-を有効にする)

## gcloud の設定変更

### 1. 現在の gcloud の設定の確認

以下コマンドを実行し、[core]の`account`と`project`が使用想定のものであるか確認する。

```sh
$ gcloud config list
（略）
[core]
account = ***@***.jp
disable_usage_reporting = True
project = ****
```

### 2. アカウントの切り替え

以下コマンドを実行すると、ブラウザが立ち上がり、アカウント選択画面が表示されるので、適切なアカウントを選択する。

```sh
gcloud auth login
```

## Project の作成

以下コマンドを実行し、GCP の新しいプロジェクトを作成する。

```sh
gcloud projects create <PROJECT_NAME> --name=<NAME>

# Options(任意):
# --set-as-default: デフォルトプロジェクトとして設定する
```

> [!IMPORTANT]
> <PROJECT_NAME>は一意にする必要がある
> 一意でない場合、エラーが発生する
> ERROR: (gcloud.projects.create) Project creation failed. The project ID you specified is already in use by another project. Please try an alternative ID.

以下コマンドを実行する。`<PROJECT_ID>`は切り替えたいプロジェクトの ID を指定する。

```sh
$ gcloud config set project <PROJECT_ID>
Updated property [core/project].
```

ここまでできたらもう一度[現在の gcloud の設定の確認](#1-現在の-gcloud-の設定の確認)をして、account と project が想定通りか確認すること。

> [!TIP]
> 以下のようにシェル変数を設定することで以降の手順で入力を省略することができる。
>
> ```sh
> PROJECT_ID=<PROJECT_ID>
> ```

## terraform 用サービスアカウント作成(gcloud から)

### 1. サービスアカウントの作成

以下コマンドを実行し、サービスアカウントを作成する。

```sh
gcloud iam service-accounts create <SERVICE_ACCOUNT_NAME> --project=<PROJECT_ID> --display-name=<SERVICE_ACCOUNT_NAME>
```

作成されたことを確認する。

```sh
gcloud iam service-accounts list
```

> [!TIP]
> 以下のようにシェル変数を設定することで以降の手順で入力を省略することができる。
>
> ```sh
> TF_SA_EMAIL=<`gcloud iam service-accounts list`を実行したときのEMAIL列の値>
> ```

### 2. サービスアカウントにロールを付与する

以下コマンドを実行し、作成したサービスアカウントにエディターロールを付与する。

```sh
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$TF_SA_EMAIL" --role="roles/editor"
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$TF_SA_EMAIL" --role="roles/resourcemanager.projectIamAdmin"
```

### 3. Terraform 用のサービスアカウントのキーを生成する

以下コマンドを実行し、サービスアカウントのキーを生成する。

```sh
gcloud iam service-accounts keys create <OUTPUT_FILE_NAME> --iam-account=$TF_SA_EMAIL
```

- `<OUTPUT_FILE_NAME>`は出力するファイル名
  - <PROJECT_ID>-sa-tf.json

## プロジェクトに請求アカウントを紐づける

1. GCP のコンソールに開発アカウントでログインする
2. コンソール上部のプルダウンメニューから今回作成したプロジェクトを選択する
3. 左のメニューから 課金 > 請求先アカウントをリンク > 請求アカウントを作成 を押下
4. Gmail 作成ウィザードに従って請求アカウントを作成する（アカウントの命名規則については[Google Cloud アカウント規則](https://code-cs.atlassian.net/wiki/x/AQAi)を参照すること）
5. 請求先情報と支払い方法を入力する
6. 請求アカウントを紐づける（TODO: 精緻化する。探り探りやったので手順が不明瞭）
   1. (開発アカウント)IAM メニューから請求アカウントを追加し、"プロジェクト請求管理者"のロールを付与する
   2. (請求アカウント)最初「My First Project」への請求が有効になっているので、それを無効にする
   3. (請求アカウント)本プロジェクトへの請求を有効にする

## GCE, Cloud Run, GCS の API を有効にする

以下コマンドを実行し、API を有効にする。
※プロジェクトに請求アカウントの情報が紐づけられている必要がある

```sh
gcloud services enable compute.googleapis.com run.googleapis.com storage.googleapis.com iam.googleapis.com cloudresourcemanager.googleapis.com cloudkms.googleapis.com

# Options(任意):
# --async: バックグラウンドで実行され、コンソールがブロックされない
```

## Terraform State 用のバケットを作成する

```sh
gcloud storage buckets create gs://devtask-tf-state-dev
```

## Artifact Registry login

### Docker 用サービスアカウントを作成する

```sh
gcloud iam service-accounts create devtask-sa-docker --project=$PROJECT_ID --display-name=devtask-sa-docker
```

> [!TIP]
> 以下のようにシェル変数を設定することで以降の手順で入力を省略することができる。
>
> ```sh
> DOCKER_SA_EMAIL=<`gcloud iam service-accounts list`を実行したときのEMAIL列の値>
> ```

### アクセストークンを作成するためのロールをサービスアカウントに付与する

```sh
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$DOCKER_SA_EMAIL" --role="roles/iam.serviceAccountTokenCreator"
```

## Project Number を取得する

```sh
PROJECT_NUMBER=$(gcloud projects list --filter=$(gcloud config get-value project) --format="value(PROJECT_NUMBER)")
# echo $PROJECT_NUMBER    // => `167734390158` のような数字
```
