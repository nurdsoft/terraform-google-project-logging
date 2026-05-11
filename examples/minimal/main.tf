module "project_logging" {
  source = "git::https://github.com/nurdsoft/terraform-google-project-logging.git?ref=v1.0.0"

  project_id = "my-gcp-project"
  bucket_id  = "my-log-bucket"
  sink_name  = "my-log-sink"
}
