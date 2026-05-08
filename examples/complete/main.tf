module "project_logging" {
  source = "git::https://github.com/nurdsoft/terraform-google-project-logging.git?ref=v1.0.0"

  project_id       = "my-gcp-project"
  bucket_id        = "my-log-bucket"
  location         = "global"
  retention_days   = 90
  sink_name        = "my-log-sink"
  sink_destination = "logging.googleapis.com/projects/my-gcp-project/locations/global/buckets/my-log-bucket"
  sink_filter      = "resource.type=\"cloud_run_revision\""

  labels = {
    env  = "production"
    team = "platform"
  }
}
