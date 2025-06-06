variable "project_id" {
  default     = null
  description = "The project ID in which we're doing this work."
  type        = string
}

variable "realm" {
  description = "Name of infrastructure realm (e.g. prod, nonprod, mgmt, or global)."
  type        = string

  validation {
    condition     = contains(["mgmt", "global", "nonprod", "prod"], var.realm)
    error_message = "Valid values for realm: nonprod, prod, mgmt, or global."
  }
}

variable "circleci_build_repositories" {
  type        = list(string)
  default     = []
  description = "The CircleCI repositories building and uploading images in the format org/repository."
  validation {
    condition = alltrue([
      for repo in var.circleci_build_repositories :
      can(regex("^\\S+/\\S+$", repo))
    ])
    error_message = "Valid values are in the following format: org/repository."
  }
}

variable "environment" {
  description = "Environment to create (like, 'dev', 'stage', or 'prod')"
  type        = string
}

variable "gha_environments" {
  description = <<-EOF
    A list of Github environments from which the deployment service account can
    deploy. Specifying a non-default value for this variable will override the
    "environment" variable in this module.

    We require a manual approval step in the workflow that pushes code to the
    production environment. You should not leverage this variable to create a
    production deployment path that bypasses the manual step. An exemption to
    this rule must be reviewed and documented, preferably in the RRA document of
    your service.
EOF
  type        = list(string)
  default     = []
}

variable "function" {
  default     = "dataservices"
  description = "The function associated with this application"
  type        = string
}

variable "risk_level" {
  description = "Risk level associated with application"
  type        = string
}

variable "application" {
  description = "The name of the application."
  type        = string
}

variable "wip_project_number" {
  default     = 324168772199
  description = "The project number of the project the workload identity provider lives in"
  type        = number
}

variable "wip_name" {
  default     = "github-actions"
  description = "The name of the workload identity provider"
  type        = string
}

variable "github_repository" {
  type        = string
  default     = null
  description = <<-EOT
    The Github repository building the image and running the deployment workflows in the format
    org/repository. Can be overridden by `github_build_repositories` and `github_deploy_repositories`,
    which take precendence over this variable if provided.
  EOT
  validation {
    condition = (
      var.github_repository == null || can(regex("^\\S+/\\S+$", var.github_repository))
    )
    error_message = "Valid values are in the following format: org/repository."
  }
}

variable "github_deploy_repositories" {
  type        = list(string)
  default     = []
  description = <<-EOT
    The Github repositories deploying helm charts in the format org/repository.
    Overrides `github_repository` for the deploy service account.
  EOT
  validation {
    condition = alltrue([
      for repo in var.github_deploy_repositories :
      can(regex("^\\S+/\\S+$", repo))
    ])
    error_message = "Valid values are in the following format: org/repository."
  }
}

variable "github_build_repositories" {
  type        = list(string)
  default     = []
  description = <<-EOT
    The Github repositories building and uploading images in the format org/repository.
    Overrides `github_repository` for the artifact-writer service account.
  EOT
  validation {
    condition = alltrue([
      for repo in var.github_build_repositories :
      can(regex("^\\S+/\\S+$", repo))
    ])
    error_message = "Valid values are in the following format: org/repository."
  }
}

variable "github_require_build_env" {
  type        = bool
  default     = true
  description = <<-EOT
    Whether to require GitHub Actions jobs to use an environment called "build" to be
    able to get access to the artifact-writer service account and push Docker images.
  EOT
}

variable "log_destination" {
  default     = "bucket"
  type        = string
  description = "The destination for tenant logs, defaults to bucket. Valid options are \"bucket\" and \"bigquery\""
}

variable "log_analytics" {
  type        = bool
  description = "Enable log analytics for log bucket"
  default     = false
}

variable "log_retention_days" {
  type        = number
  description = "Log retention in days. Defaults to 90 days."
  default     = 90
}
