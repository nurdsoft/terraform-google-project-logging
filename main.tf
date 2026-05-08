resource "google_logging_project_bucket_config" "this" {
  project        = var.project_id
  bucket_id      = var.bucket_id
  location       = var.location
  retention_days = var.retention_days
}

resource "google_logging_project_sink" "this" {
  project                = var.project_id
  name                   = var.sink_name
  destination            = "logging.googleapis.com/projects/${var.project_id}/locations/${google_logging_project_bucket_config.this.location}/buckets/${google_logging_project_bucket_config.this.bucket_id}"
  filter                 = var.sink_filter
  unique_writer_identity = true
}
