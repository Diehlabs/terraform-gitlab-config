terraform {
  backend "http" {
    address        = "https://gitlab.com/api/v4/projects/38494233/terraform/state/gitlab-management"
    lock_address   = "https://gitlab.com/api/v4/projects/38494233/terraform/state/gitlab-management/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/38494233/terraform/state/gitlab-management/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = 5
  }
}
