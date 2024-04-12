locals {
    chiba_gmail_admin_username = "TBD" // if "abcdef@gmail.com", then "abcdef"
    chiba_admin_roles = [
        "roles/admin"
    ]
}

resource "google_project_iam_member" "admin_chiba" {
    for_each = toset(local.chiba_admin_roles) // 指定したリストごとにメンバー・ロールのマッピングを行う
    project =  var.project
    member = "${local.chiba_gmail_admin_username}@gmail.com"
    role = each.value
}