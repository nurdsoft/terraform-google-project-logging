# terraform-google-project-logging

## Overview

This Terraform module provisions GCP project-level logging resources using `google_logging_project_bucket_config` and `google_logging_project_sink`. It standardises log bucket and sink configuration across projects so that these resources do not need to be defined as inline raw resources in each project's deploy configuration.

## Usage

`Basic`:

```hcl
module "project_logging" {
  source = "git::https://github.com/nurdsoft/terraform-google-project-logging.git?ref=v1.0.0"

  project_id = "my-gcp-project"
  bucket_id  = "my-log-bucket"
  sink_name  = "my-log-sink"
}
```

`With filter`:

```hcl
module "project_logging" {
  source = "git::https://github.com/nurdsoft/terraform-google-project-logging.git?ref=v1.0.0"

  project_id  = "my-gcp-project"
  bucket_id   = "my-log-bucket"
  sink_name   = "my-log-sink"
  sink_filter = "resource.type=\"cloud_run_revision\""
}
```

`Complete`:

```hcl
module "project_logging" {
  source = "git::https://github.com/nurdsoft/terraform-google-project-logging.git?ref=v1.0.0"

  project_id     = "my-gcp-project"
  bucket_id      = "my-log-bucket"
  location       = "global"
  retention_days = 90
  sink_name      = "my-log-sink"
  sink_filter    = "resource.type=\"cloud_run_revision\""
}
```

## IAM

The sink uses a dedicated writer identity (`unique_writer_identity = true`). After creating the module, grant that identity write access to the log bucket, otherwise logs will be silently dropped:

```hcl
resource "google_project_iam_member" "log_sink_writer" {
  project = "my-gcp-project"
  role    = "roles/logging.bucketWriter"
  member  = module.project_logging.sink_writer_identity
}
```

## Assumptions

- A basic understanding of [Git](https://git-scm.com/). Git version `>= 2.33.0`.
- An existing GCP IAM user or role with permission to create/update/delete `google_logging_project_bucket_config` and `google_logging_project_sink` resources.
- [GCloud CLI](https://cloud.google.com/sdk/docs/install) `>= 465.0.0`
- A basic understanding of [Terraform](https://www.terraform.io/). Terraform version `>= 1.3`.

## Test

```sh
gcloud init
gcloud auth application-default login
cd examples/minimal
terraform init
terraform plan
terraform apply
terraform destroy
```

## Contributions

Contributions are always welcome. As such, this project uses the `main` branch as the source of truth to track changes.

**Step 1**. Clone this project.

```sh
# Using Git
$ git clone git@github.com:nurdsoft/terraform-google-project-logging.git

# Using HTTPS
$ git clone https://github.com/nurdsoft/terraform-google-project-logging.git
```

**Step 2**. Checkout a feature branch: `git checkout -b feat/abc`.

**Step 3**. Validate the change/s locally by executing the steps defined under [Test](#test).

**Step 4**. If testing is successful, commit and push the new change/s to the remote.

```sh
$ git add file1 file2 ...

$ git commit -m "Adding some change"

$ git push --set-upstream origin feat/abc
```

**Step 5**. Once pushed, create a [PR](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) and assign it to a member for review.

- **Important Note**: It can be helpful to attach the `terraform plan` output in the PR.

**Step 6**. A team member reviews/approves/merges the change/s.

**Step 7**. Once merged, deploy the required changes as needed.

**Step 8**. Once deployed, verify that the changes have been deployed.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3 |
| google | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 6.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | GCP project ID | `string` | n/a | yes |
| bucket\_id | ID of the log bucket. Must be unique within the project | `string` | n/a | yes |
| sink\_name | Name of the log sink | `string` | n/a | yes |
| location | Location for the log bucket (e.g. `global`, `us-central1`) | `string` | `"global"` | no |
| retention\_days | Number of days log entries are retained in the bucket | `number` | `30` | no |
| sink\_filter | Log filter expression. Leave empty to export all log entries | `string` | `""` | no |


## Outputs

| Name | Description |
|------|-------------|
| bucket\_resource\_name | Full resource name of the log bucket (`projects/{project}/locations/{location}/buckets/{bucket_id}`) |
| sink\_id | Full resource name of the log sink |
| sink\_writer\_identity | Service account identity of the sink. Grant this identity write access to the destination bucket |

## Authors

Module is maintained by [Nurdsoft](https://github.com/nurdsoft).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/nurdsoft/terraform-google-project-logging/blob/main/LICENSE) for full details.
