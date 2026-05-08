output "bucket_name" {
  description = "Full resource name of the log bucket."
  value       = google_logging_project_bucket_config.this.id
}

output "sink_id" {
  description = "Full resource name of the log sink."
  value       = google_logging_project_sink.this.id
}

output "sink_writer_identity" {
  description = "Service account identity of the sink. Grant this identity write access to the destination bucket."
  value       = google_logging_project_sink.this.writer_identity
}
