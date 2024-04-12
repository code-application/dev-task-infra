# Terraform 化メモ

## IAM

### individual account

- owner
  - 課金対象アカウント
- developer
  - それぞれが使用する管理者権限を持つユーザー

### service account

- terraform
  - Terrform からコードを実行し、GCP リソースを作成するために使用する
  - 権限
    - editor
- docker login
  - ローカルで Artifact Registry にログインするときに権限借用で使用する
  - 権限
    - サービスアカウントトークン作成者
    - サービスアカウントユーザー
- github actions
  - GitHub Actions から GCP にデプロイするときに権限借用で使用する
  - 権限
    - サービスアカウントユーザー
    - Cloud Run 管理者
    - Artifact Registry 書き込み
- workload identity principalset
  - GitHub Actions 内で WorkloadIdentity を使用してサービスアカウントのアクセストークンを取得するために使用する
  - principalSet://iam.googleapis.com/projects/102437470994/locations/global/workloadIdentityPools/code-devtask-workload-pool-dev/attribute.repository/code-application/dev-task-api
  - 権限
    - Workload Identity ユーザー

### custom role

### iam role binding
