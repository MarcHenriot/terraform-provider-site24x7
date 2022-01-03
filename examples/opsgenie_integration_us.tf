terraform {
  # Require Terraform version 0.15.x (recommended)
  required_version = "~> 0.15.0"

  required_providers {
    site24x7 = {
      source  = "site24x7/site24x7"
      # Update the latest version from https://registry.terraform.io/providers/site24x7/site24x7/latest
      version = "0.0.1-beta.11"
    }
  }
}

// Authentication API doc - https://www.site24x7.com/help/api/#authentication
provider "site24x7" {
  // The client ID will be looked up in the SITE24X7_OAUTH2_CLIENT_ID
  // environment variable if the attribute is empty or omitted.
  oauth2_client_id = "<SITE24X7_OAUTH2_CLIENT_ID>"

  // The client secret will be looked up in the SITE24X7_OAUTH2_CLIENT_SECRET
  // environment variable if the attribute is empty or omitted.
  oauth2_client_secret = "<SITE24X7_OAUTH2_CLIENT_SECRET>"

  // The refresh token will be looked up in the SITE24X7_OAUTH2_REFRESH_TOKEN
  // environment variable if the attribute is empty or omitted.
  oauth2_refresh_token = "<SITE24X7_OAUTH2_REFRESH_TOKEN>"

  // Specify the data center from which you have obtained your
  // OAuth client credentials and refresh token. It can be (US/EU/IN/AU/CN).
  data_center = "US"

  // The minimum time to wait in seconds before retrying failed Site24x7 API requests.
  retry_min_wait = 1

  // The maximum time to wait in seconds before retrying failed Site24x7 API
  // requests. This is the upper limit for the wait duration with exponential
  // backoff.
  retry_max_wait = 30

  // Maximum number of Site24x7 API request retries to perform until giving up.
  max_retries = 4

}

resource "site24x7_opsgenie_integration" "opsgenie_integration" {
  // (Required) Display name for the integration
  name           = "OpsGenie Integration With Site24x7"
  // (Required) URL to be invoked for action execution
  url            = "https://api.opsgenie.com/v1/json/site24x7?apiKey=a19y1cdd-bz7a-455a-z4b1-c1528323502s"
  // (Required) Resource Type associated with this integration
  // https://www.site24x7.com/help/api/#resource_type_constants
  // Monitor Group not supported
  selection_type = 2
  // (Optional) Monitors associated with the integration
  monitors       = ["4567"]
  // (Optional) Configuration to create an incident during a TROUBLE alert
  trouble_alert  = false
  // (Optional) Configuration to resolve the incidents manually when the monitor changes to UP status
  manual_resolve = true
  // (Optional) List of tag IDs to be associated with the integration
  alert_tags_id  = ["123"]
}
