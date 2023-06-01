terraform {
  required_providers {
    coder = {
      source  = "coder/coder"
      version = "0.7.0"
    }
  }
}

data "coder_parameter" "sample" {
  name        = "Sample"
  type        = "string"
  description = "blah blah"
  default     = "ok"
}

data "coder_parameter" "example" {
  name = "Example"
  type = "string"
  option {
    name  = "First Option"
    value = "first"
  }
  option {
    name  = "Second Option"
    value = "second"
  }
}

// Plugin revision v0.7.0 requires defining "min" or "max" rules together.
data "coder_parameter" "number_example_min_max" {
  name = "number_example_min_max"
  type = "number"
  default = 4
  validation {
    min = 3
    max = 6
  }
}

data "coder_parameter" "number_example" {
  name = "number_example"
  type = "number"
  default = 4
}

resource "coder_agent" "dev" {
  os   = "windows"
  arch = "arm64"
}

resource "null_resource" "dev" {
  depends_on = [coder_agent.dev]
}
