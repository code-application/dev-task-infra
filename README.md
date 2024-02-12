# lp-infra

## インフラ初期設定

1. Terraform のインストール
2. kubectl のインストール
3. gcloud のインストール
4. [Project の作成](#project-の作成)
5. [gcloud の設定変更](#gcloud-の設定変更)
6. [terraform 用サービスアカウント作成(gcloud から)](#terraform-用サービスアカウント作成gcloud-から)
7. [GCE, GKE の API を有効にする](#gce-gke-の-api-を有効にする)

## Project の作成

以下コマンドを実行し、GCP の新しいプロジェクトを作成する。

```
$ gcloud projects create <PROJECT_NAME> --name=<NAME>

# Options(任意):
# --set-as-default: デフォルトプロジェクトとして設定する
```

## gcloud の設定変更

### 1. 現在の gcloud の設定の確認

以下コマンドを実行し、[core]の`account`と`project`が使用想定のものであるか確認する。

```
$ gcloud config list
（略）
[core]
account = ***@***.jp
disable_usage_reporting = True
project = ****
```

### 2. アカウントの切り替え

以下コマンドを実行すると、ブラウザが立ち上がり、アカウント選択画面が表示されるので、適切なアカウントを選択する。

```
$ gcloud auth login
```

### 3. プロジェクトの切り替え

以下コマンドを実行する。`<PROJECT_ID>`は切り替えたいプロジェクトの ID を指定する。

```
$ gcloud config set project <PROJECT_ID>
Updated property [core/project].
```

## terraform 用サービスアカウント作成(gcloud から)

### 1. サービスアカウントの作成

以下コマンドを実行し、サービスアカウントを作成する。

```
$ gcloud iam service-accounts create <SERVICE_ACCOUNT_NAME> --project=<PROJECT_ID> --display-name=<SERVICE_ACCOUNT_NAME>
```

作成されたことを確認する。

```
$ gcloud iam service-accounts list
```

### 2. サービスアカウントにロールを付与する

以下コマンドを実行し、作成したサービスアカウントにエディターロールを付与する。

```
$ gcloud projects add-iam-policy-binding <PROJECT_ID> --member=" serviceAccount:<SERVICE_ACCOUNT_EMAIL>" --role="roles/editor"
```

`<SERVICE_ACCOUNT_EMAIL>`の確認方法は以下コマンド。出力結果の`EMAIL`列を確認。

```
$ gcloud iam service-accounts list
```

### 3.

gcloud iam service-accounts keys create code-devtask-sa-tf.json --iam-account=code-devtask-sa-tf@code-dev-task-test-1.iam.gserviceaccount.com

## GCE, GKE の API を有効にする

以下コマンドを実行し、API を有効にする。

```
gcloud services enable container.googleapis.com compute.googleapis.com run.googleapis.com

# Options(任意):
--async: バックグラウンドで実行され、コンソールがブロックされない
```

# Artifact Registry login

create service account for docker login
gcloud iam service-accounts create code-devtask-sa-docker --project=code-dev-task-test-1 --display-name=code-devtask-sa-docker

add role to create accesstoken for serviceaccount
gcloud projects add-iam-policy-binding code-dev-task-test-1 --member="serviceAccount:code-devtask-sa-docker@code-dev-task-test-1.iam.gserviceaccount.com" --role="roles/iam.serviceAccountTokenCreator"
