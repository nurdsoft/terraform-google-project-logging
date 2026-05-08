variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "bucket_id" {
  description = "ID of the log bucket. Must be unique within the project."
  type        = string
}

variable "location" {
  description = "Location for the log bucket (e.g. \"global\", \"us-central1\")."
  type        = string
  default     = "global"
}

variable "retention_days" {
  description = "Number of days log entries are retained in the bucket."
  type        = number
  default     = 30
}

variable "sink_name" {
  description = "Name of the log sink."
  type        = string
}

variable "sink_destination" {
  description = "Destination URI for the log sink (e.g. \"logging.googleapis.com/projects/{project}/locations/{location}/buckets/{bucket_id}\")."
  type        = string
}

variable "sink_filter" {
  description = "Log filter expression. Leave empty to export all log entries."
  type        = string
  default     = ""
}

variable "labels" {
  description = "Labels to apply to resources."
  type        = map(string)
  default     = {}
}
