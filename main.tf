resource "google_logging_project_bucket_config" "this" {
  project        = var.project_id
  bucket_id      = var.bucket_id
  location       = var.location
  retention_days = var.retention_days
}

resource "google_logging_project_sink" "this" {
  project                = var.project_id
  name                   = var.sink_name
  destination            = var.sink_destination
  filter                 = var.sink_filter
  unique_writer_identity = true
}
